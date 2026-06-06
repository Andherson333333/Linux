# bpftrace
Tracing en tiempo real del kernel Linux via eBPF. Sin reinicios, sin modificar aplicaciones.

## Table of Contents
* [Qué es](#qué-es)
* [Requisitos](#requisitos)
* [Instalación](#instalación)
* [Conceptos básicos](#conceptos-básicos)
* [Comandos más útiles](#comandos-más-útiles)
* [Probado en](#probado-en)

## Qué es
bpftrace permite ver lo que hace el kernel y cualquier proceso en tiempo real — qué archivos abre, qué conexiones hace, cuánto tarda un I/O, qué errores tiene. Todo sin instalar agentes ni tocar las apps.

## Requisitos
```bash
# Kernel 5.15+ con BTF
ls /sys/kernel/btf/vmlinux
# JIT habilitado
sysctl net.core.bpf_jit_enable
# Si retorna 0:
sysctl -w net.core.bpf_jit_enable=1
```

## Instalación
```bash
# Debian / Ubuntu
apt install -y bpftrace
# Verificar
bpftrace --version
bpftrace -e 'BEGIN { printf("OK\n"); exit(); }'
```
![Diagram](https://github.com/Andherson333333/Linux/blob/main/eBPF-bpftrace/imagenes/eBPF-bpftrace-4.png)

---

## Conceptos básicos
Un programa bpftrace tiene esta forma:
```
probe /filtro/ {
    acción
}
```

**Probes más usados:**
| Probe | Qué hookea |
|---|---|
| `tracepoint:syscalls:sys_enter_execve` | Cuando se ejecuta un comando |
| `tracepoint:syscalls:sys_enter_openat` | Cuando se abre un archivo |
| `tracepoint:syscalls:sys_exit_openat` | Resultado de abrir un archivo |
| `kprobe:tcp_connect` | Nueva conexión TCP |
| `kprobe:oom_kill_process` | Proceso matado por OOM |
| `interval:s:N` | Cada N segundos |

**Variables disponibles:**
| Variable | Valor |
|---|---|
| `comm` | Nombre del proceso |
| `pid` | PID |
| `uid` | UID del usuario |
| `username` | Nombre del usuario |
| `args` | Argumentos del probe |
| `nsecs` | Timestamp en nanosegundos |

> **Nota:** bpftrace 0.19+ usa `args.campo` — versiones anteriores usan `args->campo`

---

## Comandos más útiles

### Ver qué comandos ejecuta el sistema
```bash
bpftrace -e 'tracepoint:syscalls:sys_enter_execve {
  printf("uid=%-4d user=%-12s cmd=%s\n", uid, username, str(args.filename));
}'
```
![Diagram](https://github.com/Andherson333333/Linux/blob/main/eBPF-bpftrace/imagenes/eBPF-bpftrace-5.png)

### Ver qué archivos abre un proceso
```bash
bpftrace -e 'tracepoint:syscalls:sys_enter_openat /comm == "nginx"/ {
  printf("%s\n", str(args.filename));
}'
```

### Ver errores al abrir archivos
```bash
bpftrace -e '
tracepoint:syscalls:sys_enter_openat { @fn[tid] = args.filename; }
tracepoint:syscalls:sys_exit_openat /args.ret < 0/ {
  printf("ERROR %d — %s → %s\n", args.ret, comm, str(@fn[tid]));
  delete(@fn[tid]);
}'
```

### Ver conexiones TCP nuevas
```bash
bpftrace -e 'kprobe:tcp_connect {
  printf("%-16s pid=%-6d uid=%d\n", comm, pid, uid);
}'
```

### Latencia de disco — histograma
```bash
bpftrace -e '
tracepoint:block:block_rq_issue { @start[args.dev, args.sector] = nsecs; }
tracepoint:block:block_rq_complete /@start[args.dev, args.sector]/ {
  @us = hist((nsecs - @start[args.dev, args.sector]) / 1000);
  delete(@start[args.dev, args.sector]);
}
interval:s:10 { print(@us); clear(@us); }'
```

### Top de syscalls por proceso
```bash
bpftrace -e '
tracepoint:raw_syscalls:sys_enter { @[comm] = count(); }
interval:s:5 { print(@, 10); clear(@); }'
```
![Diagram](https://github.com/Andherson333333/Linux/blob/main/eBPF-bpftrace/imagenes/eBPF-bpftrace-6.png)

### OOM kills en tiempo real
```bash
bpftrace -e 'kprobe:oom_kill_process {
  printf("OOM KILL — %s pid=%d\n", comm, pid);
}'
```

---

## Probado en
| OS | Kernel | bpftrace |
|---|---|---|
| Debian 13 | 6.12 | 0.23.2 |
