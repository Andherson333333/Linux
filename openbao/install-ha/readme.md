# Instalación de OpenBao en HA (3 nodos, Raft)

Requiere: 3 hosts Linux (Ubuntu 24.04+), red entre ellos, certificado
TLS válido (CN o SAN = hostname común, ej. `vault.tu-dominio.io`),
y auto-unseal configurado aparte (KMS o Transit — no cubierto aquí).

IPs de ejemplo usadas en esta guía (ajustar a tu entorno real):
- Nodo 1: `192.168.50.11`
- Nodo 2: `192.168.50.12`
- Nodo 3: `192.168.50.13`

## 1. Instalar el paquete en los 3 nodos

```bash
curl -LO https://github.com/openbao/openbao/releases/download/v2.6.1/openbao_2.6.1_linux_amd64.deb
sudo apt install -y ./openbao_2.6.1_linux_amd64.deb
```

## 2. Colocar el certificado TLS en los 3 nodos

```bash
sudo mkdir -p /opt/openbao/tls
sudo cp tls.crt tls.key /opt/openbao/tls/
sudo chown -R openbao:openbao /opt/openbao/tls
sudo chmod 600 /opt/openbao/tls/tls.key
```

## 3. Config por nodo

Ajustar IPs y `node_id` según corresponda. El `leader_tls_servername`
debe coincidir con el CN/SAN del certificado (mismo valor en los 3).

### `/etc/openbao/openbao.hcl` — Nodo 1 (IP 192.168.50.11)

```hcl
ui = true

storage "raft" {
  path    = "/opt/openbao/data"
  node_id = "vault-infra-1"

  retry_join {
    leader_api_addr       = "https://192.168.50.12:8200"
    leader_tls_servername = "vault.tu-dominio.io"
  }
  retry_join {
    leader_api_addr       = "https://192.168.50.13:8200"
    leader_tls_servername = "vault.tu-dominio.io"
  }
}

listener "tcp" {
  address       = "0.0.0.0:8200"
  tls_cert_file = "/opt/openbao/tls/tls.crt"
  tls_key_file  = "/opt/openbao/tls/tls.key"
}

cluster_addr  = "https://192.168.50.11:8201"
api_addr      = "https://192.168.50.11:8200"
disable_mlock = true
```

### `/etc/openbao/openbao.hcl` — Nodo 2 (IP 192.168.50.12)

```hcl
ui = true

storage "raft" {
  path    = "/opt/openbao/data"
  node_id = "vault-infra-2"

  retry_join {
    leader_api_addr       = "https://192.168.50.11:8200"
    leader_tls_servername = "vault.tu-dominio.io"
  }
  retry_join {
    leader_api_addr       = "https://192.168.50.13:8200"
    leader_tls_servername = "vault.tu-dominio.io"
  }
}

listener "tcp" {
  address       = "0.0.0.0:8200"
  tls_cert_file = "/opt/openbao/tls/tls.crt"
  tls_key_file  = "/opt/openbao/tls/tls.key"
}

cluster_addr  = "https://192.168.50.12:8201"
api_addr      = "https://192.168.50.12:8200"
disable_mlock = true
```

### `/etc/openbao/openbao.hcl` — Nodo 3 (IP 192.168.50.13)

```hcl
ui = true

storage "raft" {
  path    = "/opt/openbao/data"
  node_id = "vault-infra-3"

  retry_join {
    leader_api_addr       = "https://192.168.50.11:8200"
    leader_tls_servername = "vault.tu-dominio.io"
  }
  retry_join {
    leader_api_addr       = "https://192.168.50.12:8200"
    leader_tls_servername = "vault.tu-dominio.io"
  }
}

listener "tcp" {
  address       = "0.0.0.0:8200"
  tls_cert_file = "/opt/openbao/tls/tls.crt"
  tls_key_file  = "/opt/openbao/tls/tls.key"
}

cluster_addr  = "https://192.168.50.13:8201"
api_addr      = "https://192.168.50.13:8200"
disable_mlock = true
```

## 4. Levantar el servicio en los 3 nodos

```bash
sudo mkdir -p /opt/openbao/data
sudo chown -R openbao:openbao /opt/openbao/data /etc/openbao/openbao.hcl
sudo touch /etc/openbao/openbao.env
sudo systemctl enable --now openbao
```

## 5. Inicializar (solo en el Nodo 1, una sola vez)

```bash
export BAO_ADDR='https://192.168.50.11:8200'
bao operator init
```

Guardar las unseal keys y el root token fuera del servidor, en un
gestor de secretos separado.

```bash
bao operator unseal   # 3 veces con 3 keys distintas
bao login
```

Los nodos 2 y 3 se unen automáticamente al cluster vía `retry_join` —
solo necesitan que alguien los desellé también:

```bash
# En nodo 2 y nodo 3
export BAO_ADDR='https://IP_DEL_PROPIO_NODO:8200'
bao operator unseal   # 3 veces
```

## 6. Verificar el cluster

```bash
bao operator raft list-peers
```

Debe mostrar los 3 nodos, uno como `leader` y dos como `follower`.
