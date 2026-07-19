# ebpf-monitoring

Stack de observabilidad a nivel kernel para Linux. Métricas reales del sistema, logs de auditoría y eventos del kernel — todo centralizado en Grafana.

## Qué hace

### Métricas del sistema
CPU, RAM, disco y red de cada nodo via node_exporter integrado en Alloy. Dashboard **Node Exporter Full (1860)** listo para importar.

### Métricas del kernel
Latencia real de disco, page cache, TCP retransmits, OOM kills y softirq via **ebpf_exporter**. Sin instrumentar aplicaciones, directo desde el kernel.

### Auditoría de comandos por usuario
Cada comando que ejecuta cualquier usuario en el sistema queda registrado en tiempo real:
```
2026-06-07T13:21:05 event=exec uid=1000 user=soadmin pid=2341 comm=bash cmd=/usr/bin/curl
2026-06-07T13:21:05 event=tcp_connect uid=1000 user=soadmin pid=2341 comm=curl
2026-06-07T13:21:10 event=file_error uid=1000 user=soadmin pid=2342 comm=cat error=EACCES file=/etc/shadow
```

Filtrable en Grafana/Loki por usuario, evento, proceso o nodo.

## Arquitectura

```
[ Cada nodo cliente ]
  bpftrace (audit.bt)     → /var/log/bpftrace-audit.log
  ebpf_exporter           → :9435 (métricas kernel)
  Grafana Alloy           → scrape local + push al servidor

[ Servidor de monitoreo ]
  Prometheus  :9090       → almacena métricas
  Loki        :3100       → almacena logs
  Grafana     :3000       → dashboards y exploración
```

## Eventos capturados por bpftrace

| Evento | Descripción |
|---|---|
| `exec` | Comandos ejecutados — todos los usuarios |
| `tcp_connect` | Conexiones TCP nuevas por proceso y usuario |
| `file_error` | Archivos sin permiso (EACCES) o inexistentes (ENOENT) |
| `oom_kill` | Proceso matado por falta de memoria |
| `sigsegv` | Proceso que crasheó con segfault |


## Filtros disponibles en Grafana (Loki)

```logql
# Ver comandos de un usuario específico
{job="bpftrace-audit"} | logfmt | user="soadmin"

# Ver solo conexiones TCP
{job="bpftrace-audit", event="tcp_connect"}

# Ver errores de archivos
{job="bpftrace-audit", event="file_error"}

# Ver todos los logs del sistema
{job="sistema", host="nombre-nodo"}

# Ver logs de systemd
{job="journal", host="nombre-nodo"}
```


## Estructura del repo

```
server/         stack Prometheus + Loki + Grafana
client/         agente instalado en cada nodo
dashboards/     dashboard JSON de ebpf_exporter
```

## Inicio rápido

1. Levantar el servidor → `server/`
2. Instalar el cliente en cada nodo → `client/`
3. Importar dashboards → `dashboards/`


## Requisitos

- Linux kernel 5.15+ con BTF
- Docker + Docker Compose
- Debian 12/13 o Ubuntu 22.04/24.04

## Probado en

| OS | Kernel |
|---|---|
| Debian 13 | 6.12 |
