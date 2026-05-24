#!/bin/bash
# ebpf-setup.sh — aplica configuración de eBPF para producción
# Requiere root

[ "$EUID" -ne 0 ] && echo "Run as root" && exit 1

cat > /etc/sysctl.d/99-ebpf.conf << 'EOF'
net.core.bpf_jit_enable = 1
net.core.bpf_jit_harden = 1
kernel.unprivileged_bpf_disabled = 2
kernel.perf_event_paranoid = 1
EOF

sysctl --system --quiet

echo "Done. Current values:"
sysctl net.core.bpf_jit_enable net.core.bpf_jit_harden kernel.unprivileged_bpf_disabled kernel.perf_event_paranoid
