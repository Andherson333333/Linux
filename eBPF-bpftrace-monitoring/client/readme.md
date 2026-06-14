# Client — Agente de Monitoreo

Todo lo que se instala en cada nodo que se quiere monitorear.

## Componentes

| Componente | Tipo | Función |
|---|---|---|
| bpftrace + audit.bt | systemd service | Auditoría de eventos kernel |
| ebpf_exporter | systemd service | Métricas kernel → :9435 |
| Grafana Alloy | docker compose | Recolecta todo y envía al servidor |

## Archivos

```
bpftrace/
  audit.bt                    script de auditoría de eventos
  bpftrace-audit.service      servicio systemd

ebpf-exporter/
  ebpf_exporter.service       servicio systemd

alloy/
  docker-compose.yml          contenedor Alloy
  config.alloy                configuración completa
```

## Requisitos

- Debian 12/13 o Ubuntu 22.04/24.04
- Kernel 5.15+ con BTF: `ls /sys/kernel/btf/vmlinux`
- Docker + Docker Compose
- root

## Instalación

### 1. Crear estructura de archivos

```bash
# bpftrace
mkdir -p /etc/bpftrace
chmod 700 /etc/bpftrace
touch /etc/bpftrace/audit.bt
chmod 600 /etc/bpftrace/audit.bt

# log
touch /var/log/bpftrace-audit.log
chmod 600 /var/log/bpftrace-audit.log

# systemd
touch /etc/systemd/system/bpftrace-audit.service
touch /etc/systemd/system/ebpf_exporter.service

# ebpf_exporter
mkdir -p /etc/ebpf_exporter

# alloy
mkdir -p /opt/alloy
touch /opt/alloy/docker-compose.yml
touch /opt/alloy/config.alloy
```

### 2. Pegar contenido en cada archivo

```bash
nano /etc/bpftrace/audit.bt
nano /etc/systemd/system/bpftrace-audit.service
nano /etc/systemd/system/ebpf_exporter.service
nano /opt/alloy/docker-compose.yml
nano /opt/alloy/config.alloy
```

> Ver contenido de cada archivo en el repo

### 3. Instalar dependencias

```bash
# bpftrace
apt install -y bpftrace

# ebpf_exporter — descargar release
VERSION=$(curl -s https://api.github.com/repos/cloudflare/ebpf_exporter/releases/latest | grep tag_name | cut -d'"' -f4)
cd /tmp
curl -LO https://github.com/cloudflare/ebpf_exporter/releases/download/${VERSION}/ebpf_exporter_with_examples.x86_64.tar.gz
tar xzf ebpf_exporter_with_examples.x86_64.tar.gz
cd ebpf_exporter-${VERSION}

install -m 755 ebpf_exporter /usr/local/bin/ebpf_exporter

cd examples/
cp biolatency.yaml      biolatency.bpf.o      /etc/ebpf_exporter/
cp oomkill.yaml         oomkill.bpf.o          /etc/ebpf_exporter/
cp tcp-retransmit.yaml  tcp-retransmit.bpf.o   /etc/ebpf_exporter/
cp cachestat.yaml       cachestat.bpf.o        /etc/ebpf_exporter/
cp softirq-latency.yaml softirq-latency.bpf.o  /etc/ebpf_exporter/
```

### 4. Activar servicios

```bash
systemctl daemon-reload
systemctl enable --now bpftrace-audit
systemctl enable --now ebpf_exporter
systemctl status bpftrace-audit ebpf_exporter
```

### 5. Instalar Alloy

```bash
cd /opt/alloy
docker compose up -d
docker logs -f alloy 2>&1 | grep -E "error|Done"
```

### 6. Verificar

```bash
# bpftrace
tail -f /var/log/bpftrace-audit.log

# ebpf_exporter
curl -s http://localhost:9435/metrics | grep ebpf_exporter_bio | head -5

# alloy
docker compose -f /opt/alloy/docker-compose.yml logs -f 2>&1 | grep -E "error|Done"
```

## Qué recolecta Alloy

| Fuente | Destino | Datos |
|---|---|---|
| `localhost:9435` (ebpf_exporter) | Prometheus | Latencia disco, TCP, OOM, cache |
| node_exporter interno | Prometheus | CPU, RAM, disco, red |
| `/var/log/bpftrace-audit.log` | Loki | Eventos kernel |
| journald | Loki | Logs del sistema |
| `/var/log/*.log` | Loki | Logs del sistema |

## Configuración de Alloy

Editar `/opt/alloy/config.alloy`:

```
# IP del servidor de monitoreo — cambiar en dos lugares:
http://MONITOR_IP:9090/api/v1/write
http://MONITOR_IP:3100/loki/api/v1/push

# Hostname del nodo — en docker-compose.yml:
HOST_HOSTNAME=nombre-del-nodo
```

## Logs útiles

```bash
# Ver eventos en tiempo real
tail -f /var/log/bpftrace-audit.log

# Solo comandos de usuarios reales
grep "uid=1000" /var/log/bpftrace-audit.log

# Solo conexiones TCP
grep "event=tcp_connect" /var/log/bpftrace-audit.log

# Estado de los servicios
systemctl status bpftrace-audit ebpf_exporter
```

