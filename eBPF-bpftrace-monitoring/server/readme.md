# Server — Stack de Monitoreo

Servidor central que recibe métricas y logs de todos los nodos.

## Componentes

| Servicio | Puerto | Función |
|---|---|---|
| Prometheus | 9090 | Almacena métricas |
| Loki | 3100 | Almacena logs |
| Grafana | 3000 | Dashboards |

## Archivos

```
docker-compose.yml          stack completo
prometheus.yml              configuración Prometheus
loki.yml                    configuración Loki
grafana-datasources.yml     datasources preconfigurados
```

## Instalación

### 1. Crear estructura de archivos

```bash
mkdir -p /opt/monitoring
cd /opt/monitoring
touch docker-compose.yml
touch prometheus.yml
touch loki.yml
touch grafana-datasources.yml
```

### 2. Pegar contenido en cada archivo

```bash
nano docker-compose.yml
nano prometheus.yml
nano loki.yml
nano grafana-datasources.yml
```

> Ver contenido de cada archivo en el repo

### 3. Levantar el stack

```bash
docker compose up -d
docker compose ps
```

![Stack corriendo](https://github.com/Andherson333333/Linux/blob/main/eBPF-bpftrace-monitoring/server/imagen/eBPF-bpftrace-monitoring-1.png)

## Verificar

```bash
# Todos los contenedores corriendo
docker compose ps

# Prometheus
curl -s http://localhost:9090/-/healthy

# Loki
curl -s http://localhost:3100/ready

# Grafana
curl -s http://localhost:3000/api/health
```

![Health checks](https://github.com/Andherson333333/Linux/blob/main/eBPF-bpftrace-monitoring/server/imagen/eBPF-bpftrace-monitoring-2.png)

## Accesos

| Servicio | URL | Credenciales |
|---|---|---|
| Grafana | `http://192.168.92.149:3000` | admin / admin |
| Prometheus | `http://192.168.92.149:9090` | — |
| Loki | `http://192.168.92.149:3100` | — |

## Dashboards

Importar en Grafana → Dashboards → New → Import:

| Dashboard | Cómo importar | Qué muestra |
|---|---|---|
| Node Exporter Full | ID `1860` | CPU, RAM, disco, red |
| ebpf_exporter | JSON del repo (`../dashboards/ebpf-exporter.json`) | Métricas kernel |

![Node Exporter Full](https://github.com/Andherson333333/Linux/blob/main/eBPF-bpftrace-monitoring/server/imagen/eBPF-bpftrace-monitoring-4.png)

## Versiones probadas

| Imagen | Versión |
|---|---|
| `prom/prometheus` | v3.11.2 |
| `grafana/loki` | 3.7.2 |
| `grafana/grafana` | 13.0.1 |

## Notas

- Prometheus tiene `--web.enable-remote-write-receiver` — los nodos hacen push via Alloy
- Loki retención 90 días en filesystem local
- Datasources de Grafana se provisionan automáticamente
- DNS en Grafana: si hay `SERVFAIL` interno, agregar `dns: [8.8.8.8, 1.1.1.1]` al servicio en `docker-compose.yml` (problema conocido con nftables en Debian 13)
