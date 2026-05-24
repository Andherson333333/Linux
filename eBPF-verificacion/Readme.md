# eBPF — Verificación y Configuración del Kernel

Verificar el estado de eBPF antes de desplegar herramientas como ebpf_exporter, Tetragon, Cilium, Falco, etc.
No se instala nada en esta guía.

## ¿Qué es eBPF?

Subsistema del kernel Linux que ejecuta programas sandboxed directamente en el kernel sin modificar su código ni cargar módulos. Lo relevante: puedes observar syscalls, tráfico de red, llamadas a funciones y eventos de seguridad en tiempo real, con overhead mínimo, sin tocar las aplicaciones.

```
Herramienta (Tetragon, Cilium, ebpf_exporter...)
    |
Bytecode eBPF
    |
Verifier  <-- valida seguridad, rechaza código inseguro
    |
JIT       <-- compila a código máquina nativo
    |
Hook      <-- kprobe / tracepoint / LSM / XDP
    |
Se ejecuta en respuesta a eventos del kernel
```

---

## Compatibilidad

| Distro | Kernel | BTF | Estado |
|---|---|---|---|
| Debian 13 | 6.12 | yes | listo |
| Debian 12 | 6.1 | yes | listo |
| Debian 11 | 5.10 | parcial | verificar |
| Ubuntu 24.04 | 6.8 | yes | listo |
| Ubuntu 22.04 | 5.15 | yes | listo |
| Ubuntu 20.04 | 5.4 | parcial | parcial |
| Amazon Linux 2023 | 6.1 | yes | listo |
| Amazon Linux 2 | 5.10 | parcial | verificar |
| RHEL/CentOS 9 | 5.14 | yes | listo |
| RHEL/CentOS 8 | 4.18 | no | sin CO-RE |

Mínimo recomendado: kernel 5.15 + BTF.

## Verificación

```bash
# Kernel — mínimo 5.15, ideal 6.x
uname -r

# BTF — obligatorio para CO-RE (Compile Once, Run Everywhere)
# Permite que un binario eBPF funcione en cualquier versión de kernel sin recompilar.
# El archivo es generado por el kernel al arrancar, solo lectura por diseño.
ls -la /sys/kernel/btf/vmlinux

# JIT — convierte bytecode eBPF a instrucciones nativas del CPU
# Sin JIT el kernel interpreta cada instrucción, 2-10x más lento.
# 0=intérprete, 1=JIT activo, 2=JIT+debug en dmesg
sysctl net.core.bpf_jit_enable

# JIT hardening — ofusca constantes en el código compilado
# Mitiga JIT spraying attacks. Afecta levemente el rendimiento.
# 0=ninguno, 1=solo usuarios sin privilegios, 2=todos
sysctl net.core.bpf_jit_harden

# Acceso sin privilegios — quién puede llamar a la syscall bpf()
# El =2 bloquea el valor en runtime, no se puede relajar sin reiniciar.
# 0=todos, 1=solo root, 2=solo root+bloqueado permanente
sysctl kernel.unprivileged_bpf_disabled

# Perf events — controla acceso al subsistema de profiling del kernel
# Herramientas de tracing y sampling (bpftrace, ebpf_exporter) lo necesitan.
# -1=libre, 1=normal, 2=solo root, 3=bloqueado (default Debian 13)
sysctl kernel.perf_event_paranoid

# Config compilada — verifica qué features están disponibles en este kernel
grep -E "^CONFIG_BPF|^CONFIG_DEBUG_INFO_BTF" /boot/config-$(uname -r)

# Capabilities — para cargar programas eBPF se necesita cap_bpf + cap_perfmon
# Antes del kernel 5.8 todo requería cap_sys_admin (mucho más permisivo).
capsh --print
```

### Salida esperada en Debian 13 (limpio)

```
bpf_jit_enable          = 1   OK
bpf_jit_harden          = 0   cambiar a 1 en producción
unprivileged_bpf_disabled = 2  OK
perf_event_paranoid     = 3   cambiar a 1 para herramientas de tracing
```

---

## Verificación

Ejecutar el script incluido en este repositorio:

```bash
chmod +x ebpf-check.sh
./ebpf-check.sh
```

Salida en Debian 13 (sistema limpio):

![ebpf-check output](https://github.com/Andherson333333/Linux/blob/main/eBPF-verificacion/images/eBPF-verificacion-1.png)

---

## Configuración para producción

| Parámetro | Default Debian 13 | Producción |
|---|---|---|
| `bpf_jit_enable` | 1 | 1 |
| `bpf_jit_harden` | 0 | **1** |
| `unprivileged_bpf_disabled` | 2 | 2 |
| `perf_event_paranoid` | 3 | **1** |

Puedes aplicarlo de forma manul o aplicar el scrip[ ebpf-setup.sh

```bash
# /etc/sysctl.d/99-ebpf.conf
net.core.bpf_jit_enable = 1
net.core.bpf_jit_harden = 1
kernel.unprivileged_bpf_disabled = 2
kernel.perf_event_paranoid = 1
```
![ebpf-check output](https://github.com/Andherson333333/Linux/blob/main/eBPF-verificacion/images/eBPF-verificacion-2.png)

```bash
sysctl --system
```

---

## Notas por entorno

**VMware / Proxmox** — XDP puede no funcionar según el driver de red virtual. kprobes y tracepoints siempre funcionan.

**AWS EC2** — Ubuntu 22.04/24.04 y Amazon Linux 2023 listos out-of-the-box. Driver ENA soporta XDP desde kernel 5.6+.

**Amazon Linux 2 (kernel 4.14)** — sin BTF, solo funciones básicas. Actualizar kernel antes de desplegar herramientas CO-RE.

## Troubleshooting

```bash
# Operation not permitted
capsh --print   # verificar cap_bpf + cap_perfmon

# BTF not found
ls /sys/kernel/btf/vmlinux   # si no existe, actualizar kernel

# JIT compilation failed
sysctl net.core.bpf_jit_enable   # debe ser 1

# bpftrace: Could not open BTF
apt install linux-headers-$(uname -r)

# Programa rechazado por el verifier
dmesg | tail -20

# perf_event_paranoid=3 bloquea profiling
sysctl -w kernel.perf_event_paranoid=1
```
