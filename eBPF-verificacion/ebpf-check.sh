#!/bin/bash

echo "=== eBPF System Check ==="

echo -e "\n[1] Kernel"
uname -r

echo -e "\n[2] BTF"
ls -lh /sys/kernel/btf/vmlinux 2>/dev/null || echo "FAIL not found"

echo -e "\n[3] JIT Compiler"
sysctl net.core.bpf_jit_enable

echo -e "\n[4] JIT Hardening"
sysctl net.core.bpf_jit_harden

echo -e "\n[5] Unprivileged BPF"
sysctl kernel.unprivileged_bpf_disabled

echo -e "\n[6] Perf Event Paranoid"
sysctl kernel.perf_event_paranoid

echo -e "\n[7] Kernel Config"
grep -E "^CONFIG_BPF|^CONFIG_DEBUG_INFO_BTF" /boot/config-$(uname -r) 2>/dev/null

echo -e "\n[8] Capabilities"
capsh --print | grep -E "^Current:|cap_bpf|cap_perfmon"

echo -e "\n=== Done ==="
