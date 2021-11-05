cmd_/home/henley/adacore/repos/adacore_jetson/tmp/basic_kernel_module.o := /home/henley/adacore/e3-distrib-3.8-20210805-x86_64-linux-bin/wave/aarch64-linux-linux64/gnat/install/bin/aarch64-linux-gnu-gcc -Wp,-MD,/home/henley/adacore/repos/adacore_jetson/tmp/.basic_kernel_module.o.d  -nostdinc -isystem /home/henley/adacore/e3-distrib-3.8-20210805-x86_64-linux-bin/wave/aarch64-linux-linux64/gnat/install/bin/../lib/gcc/aarch64-linux-gnu/10.3.1/include -I/home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include -I./arch/arm64/include/generated/uapi -I./arch/arm64/include/generated  -I/home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include -I./include -I/home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/uapi -I/home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/uapi -I./include/generated/uapi -include /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/kconfig.h -I/home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9//home/henley/adacore/repos/adacore_jetson/tmp -I/home/henley/adacore/repos/adacore_jetson/tmp -D__KERNEL__ -mlittle-endian -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -fshort-wchar -Werror-implicit-function-declaration -Wno-format-security -std=gnu89 -fno-PIE -mgeneral-regs-only -DCONFIG_AS_LSE=1 -fno-asynchronous-unwind-tables -mpc-relative-literal-loads -fno-pic -fno-delete-null-pointer-checks -Wno-frame-address -Wno-format-truncation -Wno-format-overflow -Wno-int-in-bool-context -Wno-address-of-packed-member -Wno-attribute-alias -Wno-address-of-packed-member -Wno-packed-not-aligned -O2 -fno-allow-store-data-races -DCC_HAVE_ASM_GOTO -Wframe-larger-than=2048 -fno-stack-protector -Wno-unused-but-set-variable -Wno-unused-const-variable -fno-omit-frame-pointer -fno-optimize-sibling-calls -fno-var-tracking-assignments -g -pg -fno-inline-functions-called-once -Wdeclaration-after-statement -Wno-pointer-sign -Wno-stringop-truncation -Wno-zero-length-bounds -Wno-array-bounds -Wno-stringop-overflow -Wno-restrict -Wno-maybe-uninitialized -fno-strict-overflow -fno-merge-all-constants -fmerge-constants -fno-stack-check -fconserve-stack -Werror=implicit-int -Werror=strict-prototypes -Werror=date-time -Werror=incompatible-pointer-types -Werror=designated-init -fmacro-prefix-map=/home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/= -Wno-packed-not-aligned  -I/home/henley/cross/Linux_for_Tegra/source/public/kernel/nvidia/include  -I/home/henley/cross/Linux_for_Tegra/source/public/kernel/nvgpu/include  -I/home/henley/cross/Linux_for_Tegra/source/public/kernel/nvgpu-next/include  -I/home/henley/cross/Linux_for_Tegra/source/public/kernel/nvidia-t23x/include  -DMODULE -mcmodel=large  -DKBUILD_BASENAME='"basic_kernel_module"'  -DKBUILD_MODNAME='"basic_kernel_module"' -c -o /home/henley/adacore/repos/adacore_jetson/tmp/.tmp_basic_kernel_module.o /home/henley/adacore/repos/adacore_jetson/tmp/basic_kernel_module.c

source_/home/henley/adacore/repos/adacore_jetson/tmp/basic_kernel_module.o := /home/henley/adacore/repos/adacore_jetson/tmp/basic_kernel_module.c

deps_/home/henley/adacore/repos/adacore_jetson/tmp/basic_kernel_module.o := \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/init.h \
    $(wildcard include/config/debug/rodata.h) \
    $(wildcard include/config/debug/set/module/ronx.h) \
    $(wildcard include/config/lto/clang.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/compiler.h \
    $(wildcard include/config/sparse/rcu/pointer.h) \
    $(wildcard include/config/trace/branch/profiling.h) \
    $(wildcard include/config/profile/all/branches.h) \
    $(wildcard include/config/kasan.h) \
    $(wildcard include/config/enable/must/check.h) \
    $(wildcard include/config/enable/warn/deprecated.h) \
    $(wildcard include/config/kprobes.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/compiler-gcc.h \
    $(wildcard include/config/arch/supports/optimized/inlining.h) \
    $(wildcard include/config/optimize/inlining.h) \
    $(wildcard include/config/gcov/kernel.h) \
    $(wildcard include/config/stack/validation.h) \
    $(wildcard include/config/arch/use/builtin/bswap.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/uapi/linux/types.h \
  arch/arm64/include/generated/asm/types.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/uapi/asm-generic/types.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/asm-generic/int-ll64.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/uapi/asm-generic/int-ll64.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/uapi/asm/bitsperlong.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/asm-generic/bitsperlong.h \
    $(wildcard include/config/64bit.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/uapi/asm-generic/bitsperlong.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/uapi/linux/posix_types.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/stddef.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/uapi/linux/stddef.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/uapi/asm/posix_types.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/uapi/asm-generic/posix_types.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/kasan-checks.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/types.h \
    $(wildcard include/config/have/uid16.h) \
    $(wildcard include/config/uid16.h) \
    $(wildcard include/config/lbdaf.h) \
    $(wildcard include/config/arch/dma/addr/t/64bit.h) \
    $(wildcard include/config/phys/addr/t/64bit.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/module.h \
    $(wildcard include/config/modules.h) \
    $(wildcard include/config/sysfs.h) \
    $(wildcard include/config/modules/tree/lookup.h) \
    $(wildcard include/config/livepatch.h) \
    $(wildcard include/config/cfi/clang.h) \
    $(wildcard include/config/unused/symbols.h) \
    $(wildcard include/config/module/sig.h) \
    $(wildcard include/config/generic/bug.h) \
    $(wildcard include/config/kallsyms.h) \
    $(wildcard include/config/smp.h) \
    $(wildcard include/config/tracepoints.h) \
    $(wildcard include/config/tracing.h) \
    $(wildcard include/config/event/tracing.h) \
    $(wildcard include/config/ftrace/mcount/record.h) \
    $(wildcard include/config/module/unload.h) \
    $(wildcard include/config/constructors.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/list.h \
    $(wildcard include/config/debug/list.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/poison.h \
    $(wildcard include/config/illegal/pointer/value.h) \
    $(wildcard include/config/page/poisoning/zero.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/uapi/linux/const.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/kernel.h \
    $(wildcard include/config/preempt/voluntary.h) \
    $(wildcard include/config/debug/atomic/sleep.h) \
    $(wildcard include/config/mmu.h) \
    $(wildcard include/config/prove/locking.h) \
    $(wildcard include/config/panic/timeout.h) \
  /home/henley/adacore/e3-distrib-3.8-20210805-x86_64-linux-bin/wave/aarch64-linux-linux64/gnat/install/lib/gcc/aarch64-linux-gnu/10.3.1/include/stdarg.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/linkage.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/stringify.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/export.h \
    $(wildcard include/config/have/underscore/symbol/prefix.h) \
    $(wildcard include/config/modversions.h) \
    $(wildcard include/config/trim/unused/ksyms.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/asm/linkage.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/bitops.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/bits.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/asm/bitops.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/asm/barrier.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/asm-generic/barrier.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/asm-generic/bitops/builtin-__ffs.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/asm-generic/bitops/builtin-ffs.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/asm-generic/bitops/builtin-__fls.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/asm-generic/bitops/builtin-fls.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/asm-generic/bitops/ffz.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/asm-generic/bitops/fls64.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/asm-generic/bitops/find.h \
    $(wildcard include/config/generic/find/first/bit.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/asm-generic/bitops/sched.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/asm-generic/bitops/hweight.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/asm-generic/bitops/arch_hweight.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/asm-generic/bitops/const_hweight.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/asm-generic/bitops/lock.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/asm-generic/bitops/non-atomic.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/asm-generic/bitops/le.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/uapi/asm/byteorder.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/byteorder/little_endian.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/uapi/linux/byteorder/little_endian.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/swab.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/uapi/linux/swab.h \
  arch/arm64/include/generated/asm/swab.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/uapi/asm-generic/swab.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/byteorder/generic.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/log2.h \
    $(wildcard include/config/arch/has/ilog2/u32.h) \
    $(wildcard include/config/arch/has/ilog2/u64.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/typecheck.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/printk.h \
    $(wildcard include/config/message/loglevel/default.h) \
    $(wildcard include/config/early/printk.h) \
    $(wildcard include/config/printk/nmi.h) \
    $(wildcard include/config/printk.h) \
    $(wildcard include/config/dynamic/debug.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/kern_levels.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/cache.h \
    $(wildcard include/config/arch/has/cache/line/size.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/uapi/linux/kernel.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/uapi/linux/sysinfo.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/asm/cache.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/asm/cachetype.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/asm/cputype.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/asm/sysreg.h \
    $(wildcard include/config/arm64/4k/pages.h) \
    $(wildcard include/config/arm64/16k/pages.h) \
    $(wildcard include/config/arm64/64k/pages.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/asm/opcodes.h \
    $(wildcard include/config/cpu/big/endian.h) \
    $(wildcard include/config/cpu/endian/be8.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/../../arm/include/asm/opcodes.h \
    $(wildcard include/config/cpu/endian/be32.h) \
    $(wildcard include/config/thumb2/kernel.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/dynamic_debug.h \
    $(wildcard include/config/jump/label.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/jump_label.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/asm/jump_label.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/asm/insn.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/stat.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/asm/stat.h \
    $(wildcard include/config/compat.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/uapi/asm/stat.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/uapi/asm-generic/stat.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/asm/compat.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/sched.h \
    $(wildcard include/config/cpu/quiet.h) \
    $(wildcard include/config/no/hz/common.h) \
    $(wildcard include/config/sched/debug.h) \
    $(wildcard include/config/prove/rcu.h) \
    $(wildcard include/config/hotplug/cpu.h) \
    $(wildcard include/config/lockup/detector.h) \
    $(wildcard include/config/detect/hung/task.h) \
    $(wildcard include/config/core/dump/default/elf/headers.h) \
    $(wildcard include/config/virt/cpu/accounting/native.h) \
    $(wildcard include/config/no/hz/full.h) \
    $(wildcard include/config/sched/autogroup.h) \
    $(wildcard include/config/bsd/process/acct.h) \
    $(wildcard include/config/taskstats.h) \
    $(wildcard include/config/audit.h) \
    $(wildcard include/config/inotify/user.h) \
    $(wildcard include/config/fanotify.h) \
    $(wildcard include/config/epoll.h) \
    $(wildcard include/config/posix/mqueue.h) \
    $(wildcard include/config/keys.h) \
    $(wildcard include/config/perf/events.h) \
    $(wildcard include/config/bpf/syscall.h) \
    $(wildcard include/config/sched/info.h) \
    $(wildcard include/config/task/delay/acct.h) \
    $(wildcard include/config/schedstats.h) \
    $(wildcard include/config/sched/smt.h) \
    $(wildcard include/config/sched/mc.h) \
    $(wildcard include/config/numa.h) \
    $(wildcard include/config/task/weight.h) \
    $(wildcard include/config/sched/walt.h) \
    $(wildcard include/config/fair/group/sched.h) \
    $(wildcard include/config/rt/group/sched.h) \
    $(wildcard include/config/thread/info/in/task.h) \
    $(wildcard include/config/cgroup/sched.h) \
    $(wildcard include/config/preempt/notifiers.h) \
    $(wildcard include/config/blk/dev/io/trace.h) \
    $(wildcard include/config/preempt/rcu.h) \
    $(wildcard include/config/tasks/rcu.h) \
    $(wildcard include/config/memcg.h) \
    $(wildcard include/config/slob.h) \
    $(wildcard include/config/compat/brk.h) \
    $(wildcard include/config/cgroups.h) \
    $(wildcard include/config/cc/stackprotector.h) \
    $(wildcard include/config/cpu/freq/times.h) \
    $(wildcard include/config/virt/cpu/accounting/gen.h) \
    $(wildcard include/config/sysvipc.h) \
    $(wildcard include/config/auditsyscall.h) \
    $(wildcard include/config/rt/mutexes.h) \
    $(wildcard include/config/debug/mutexes.h) \
    $(wildcard include/config/trace/irqflags.h) \
    $(wildcard include/config/lockdep.h) \
    $(wildcard include/config/ubsan.h) \
    $(wildcard include/config/block.h) \
    $(wildcard include/config/task/xacct.h) \
    $(wildcard include/config/cpusets.h) \
    $(wildcard include/config/futex.h) \
    $(wildcard include/config/debug/preempt.h) \
    $(wildcard include/config/numa/balancing.h) \
    $(wildcard include/config/arch/want/batched/unmap/tlb/flush.h) \
    $(wildcard include/config/fault/injection.h) \
    $(wildcard include/config/latencytop.h) \
    $(wildcard include/config/function/graph/tracer.h) \
    $(wildcard include/config/kcov.h) \
    $(wildcard include/config/uprobes.h) \
    $(wildcard include/config/bcache.h) \
    $(wildcard include/config/vmap/stack.h) \
    $(wildcard include/config/arch/wants/dynamic/task/struct.h) \
    $(wildcard include/config/have/unstable/sched/clock.h) \
    $(wildcard include/config/irq/time/accounting.h) \
    $(wildcard include/config/proc/fs.h) \
    $(wildcard include/config/stack/growsup.h) \
    $(wildcard include/config/have/copy/thread/tls.h) \
    $(wildcard include/config/have/exit/thread.h) \
    $(wildcard include/config/debug/stack/usage.h) \
    $(wildcard include/config/preempt.h) \
    $(wildcard include/config/cgroup/schedtune.h) \
    $(wildcard include/config/cpu/freq.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/uapi/linux/sched.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/sched/prio.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/uapi/asm/param.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/asm-generic/param.h \
    $(wildcard include/config/hz.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/uapi/asm-generic/param.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/capability.h \
    $(wildcard include/config/multiuser.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/uapi/linux/capability.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/threads.h \
    $(wildcard include/config/nr/cpus.h) \
    $(wildcard include/config/base/small.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/timex.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/uapi/linux/timex.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/time.h \
    $(wildcard include/config/arch/uses/gettimeoffset.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/seqlock.h \
    $(wildcard include/config/debug/lock/alloc.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/spinlock.h \
    $(wildcard include/config/debug/spinlock.h) \
    $(wildcard include/config/generic/lockbreak.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/preempt.h \
    $(wildcard include/config/preempt/count.h) \
    $(wildcard include/config/preempt/tracer.h) \
  arch/arm64/include/generated/asm/preempt.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/asm-generic/preempt.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/thread_info.h \
    $(wildcard include/config/have/arch/within/stack/frames.h) \
    $(wildcard include/config/hardened/usercopy.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/bug.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/asm/bug.h \
    $(wildcard include/config/debug/bugverbose.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/asm/brk-imm.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/asm-generic/bug.h \
    $(wildcard include/config/bug.h) \
    $(wildcard include/config/generic/bug/relative/pointers.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/restart_block.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/asm/current.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/asm/thread_info.h \
    $(wildcard include/config/arm64/sw/ttbr0/pan.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/asm/stack_pointer.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/irqflags.h \
    $(wildcard include/config/irqsoff/tracer.h) \
    $(wildcard include/config/trace/irqflags/support.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/asm/irqflags.h \
    $(wildcard include/config/serror/handler.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/asm/ptrace.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/uapi/asm/ptrace.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/asm/hwcap.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/uapi/asm/hwcap.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/asm-generic/ptrace.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/bottom_half.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/spinlock_types.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/asm/spinlock_types.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/lockdep.h \
    $(wildcard include/config/lock/stat.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/rwlock_types.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/asm/spinlock.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/asm/lse.h \
    $(wildcard include/config/as/lse.h) \
    $(wildcard include/config/arm64/lse/atomics.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/asm/alternative.h \
    $(wildcard include/config/arm64/uao.h) \
    $(wildcard include/config/foo.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/asm/cpucaps.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/asm/processor.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/string.h \
    $(wildcard include/config/binary/printf.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/uapi/linux/string.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/asm/string.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/asm/fpsimd.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/asm/hw_breakpoint.h \
    $(wildcard include/config/have/hw/breakpoint.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/asm/cpufeature.h \
    $(wildcard include/config/arm64/ssbd.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/asm/virt.h \
    $(wildcard include/config/arm64/vhe.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/asm/sections.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/asm-generic/sections.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/asm/pgtable-hwdef.h \
    $(wildcard include/config/pgtable/levels.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/rwlock.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/spinlock_api_smp.h \
    $(wildcard include/config/inline/spin/lock.h) \
    $(wildcard include/config/inline/spin/lock/bh.h) \
    $(wildcard include/config/inline/spin/lock/irq.h) \
    $(wildcard include/config/inline/spin/lock/irqsave.h) \
    $(wildcard include/config/inline/spin/trylock.h) \
    $(wildcard include/config/inline/spin/trylock/bh.h) \
    $(wildcard include/config/uninline/spin/unlock.h) \
    $(wildcard include/config/inline/spin/unlock/bh.h) \
    $(wildcard include/config/inline/spin/unlock/irq.h) \
    $(wildcard include/config/inline/spin/unlock/irqrestore.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/rwlock_api_smp.h \
    $(wildcard include/config/inline/read/lock.h) \
    $(wildcard include/config/inline/write/lock.h) \
    $(wildcard include/config/inline/read/lock/bh.h) \
    $(wildcard include/config/inline/write/lock/bh.h) \
    $(wildcard include/config/inline/read/lock/irq.h) \
    $(wildcard include/config/inline/write/lock/irq.h) \
    $(wildcard include/config/inline/read/lock/irqsave.h) \
    $(wildcard include/config/inline/write/lock/irqsave.h) \
    $(wildcard include/config/inline/read/trylock.h) \
    $(wildcard include/config/inline/write/trylock.h) \
    $(wildcard include/config/inline/read/unlock.h) \
    $(wildcard include/config/inline/write/unlock.h) \
    $(wildcard include/config/inline/read/unlock/bh.h) \
    $(wildcard include/config/inline/write/unlock/bh.h) \
    $(wildcard include/config/inline/read/unlock/irq.h) \
    $(wildcard include/config/inline/write/unlock/irq.h) \
    $(wildcard include/config/inline/read/unlock/irqrestore.h) \
    $(wildcard include/config/inline/write/unlock/irqrestore.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/atomic.h \
    $(wildcard include/config/generic/atomic64.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/asm/atomic.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/asm/atomic_lse.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/asm/cmpxchg.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/asm-generic/atomic-long.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/math64.h \
    $(wildcard include/config/arch/supports/int128.h) \
  arch/arm64/include/generated/asm/div64.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/asm-generic/div64.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/time64.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/uapi/linux/time.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/uapi/linux/param.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/asm/timex.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/asm/arch_timer.h \
    $(wildcard include/config/fsl/erratum/a008585.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/clocksource/arm_arch_timer.h \
    $(wildcard include/config/arm/arch/timer.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/timecounter.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/asm-generic/timex.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/jiffies.h \
  include/generated/timeconst.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/plist.h \
    $(wildcard include/config/debug/pi/list.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/rbtree.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/rcupdate.h \
    $(wildcard include/config/tiny/rcu.h) \
    $(wildcard include/config/tree/rcu.h) \
    $(wildcard include/config/rcu/trace.h) \
    $(wildcard include/config/rcu/stall/common.h) \
    $(wildcard include/config/rcu/nocb/cpu.h) \
    $(wildcard include/config/debug/objects/rcu/head.h) \
    $(wildcard include/config/rcu/boost.h) \
    $(wildcard include/config/rcu/nocb/cpu/all.h) \
    $(wildcard include/config/no/hz/full/sysidle.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/cpumask.h \
    $(wildcard include/config/cpumask/offstack.h) \
    $(wildcard include/config/debug/per/cpu/maps.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/bitmap.h \
    $(wildcard include/config/s390.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/completion.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/wait.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/uapi/linux/wait.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/debugobjects.h \
    $(wildcard include/config/debug/objects.h) \
    $(wildcard include/config/debug/objects/free.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/ktime.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/timekeeping.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/errno.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/uapi/linux/errno.h \
  arch/arm64/include/generated/asm/errno.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/uapi/asm-generic/errno.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/uapi/asm-generic/errno-base.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/rcutree.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/nodemask.h \
    $(wildcard include/config/highmem.h) \
    $(wildcard include/config/movable/node.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/numa.h \
    $(wildcard include/config/nodes/shift.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/mm_types.h \
    $(wildcard include/config/split/ptlock/cpus.h) \
    $(wildcard include/config/arch/enable/split/pmd/ptlock.h) \
    $(wildcard include/config/have/cmpxchg/double.h) \
    $(wildcard include/config/have/aligned/struct/page.h) \
    $(wildcard include/config/transparent/hugepage.h) \
    $(wildcard include/config/kmemcheck.h) \
    $(wildcard include/config/userfaultfd.h) \
    $(wildcard include/config/aio.h) \
    $(wildcard include/config/mmu/notifier.h) \
    $(wildcard include/config/compaction.h) \
    $(wildcard include/config/x86/intel/mpx.h) \
    $(wildcard include/config/hugetlb/page.h) \
    $(wildcard include/config/hmm.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/auxvec.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/uapi/linux/auxvec.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/uapi/asm/auxvec.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/rwsem.h \
    $(wildcard include/config/rwsem/spin/on/owner.h) \
    $(wildcard include/config/rwsem/generic/spinlock.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/err.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/osq_lock.h \
  arch/arm64/include/generated/asm/rwsem.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/asm-generic/rwsem.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/uprobes.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/page-flags-layout.h \
    $(wildcard include/config/sparsemem.h) \
    $(wildcard include/config/sparsemem/vmemmap.h) \
  include/generated/bounds.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/asm/sparsemem.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/workqueue.h \
    $(wildcard include/config/debug/objects/work.h) \
    $(wildcard include/config/freezer.h) \
    $(wildcard include/config/wq/watchdog.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/timer.h \
    $(wildcard include/config/timer/stats.h) \
    $(wildcard include/config/debug/objects/timers.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/sysctl.h \
    $(wildcard include/config/sysctl.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/uidgid.h \
    $(wildcard include/config/user/ns.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/highuid.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/uapi/linux/sysctl.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/asm/page.h \
    $(wildcard include/config/arm64/page/shift.h) \
    $(wildcard include/config/arm64/cont/shift.h) \
    $(wildcard include/config/have/arch/pfn/valid.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/personality.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/uapi/linux/personality.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/asm/pgtable-types.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/asm-generic/pgtable-nopud.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/asm/memory.h \
    $(wildcard include/config/arm64/va/bits.h) \
    $(wildcard include/config/blk/dev/initrd.h) \
  arch/arm64/include/generated/asm/sizes.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/asm-generic/sizes.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/sizes.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/mmdebug.h \
    $(wildcard include/config/debug/vm.h) \
    $(wildcard include/config/debug/virtual.h) \
    $(wildcard include/config/debug/vm/pgflags.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/asm-generic/memory_model.h \
    $(wildcard include/config/flatmem.h) \
    $(wildcard include/config/discontigmem.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/pfn.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/asm-generic/getorder.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/asm/mmu.h \
    $(wildcard include/config/unmap/kernel/at/el0.h) \
    $(wildcard include/config/harden/branch/predictor.h) \
    $(wildcard include/config/memory/hotplug.h) \
    $(wildcard include/config/memory/hotremove.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/percpu.h \
    $(wildcard include/config/need/per/cpu/embed/first/chunk.h) \
    $(wildcard include/config/need/per/cpu/page/first/chunk.h) \
    $(wildcard include/config/have/setup/per/cpu/area.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/smp.h \
    $(wildcard include/config/up/late/init.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/llist.h \
    $(wildcard include/config/arch/have/nmi/safe/cmpxchg.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/asm/smp.h \
    $(wildcard include/config/arm64/acpi/parking/protocol.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/asm/percpu.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/asm-generic/percpu.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/percpu-defs.h \
    $(wildcard include/config/page/table/isolation.h) \
    $(wildcard include/config/debug/force/weak/per/cpu.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/cputime.h \
  arch/arm64/include/generated/asm/cputime.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/asm-generic/cputime.h \
    $(wildcard include/config/virt/cpu/accounting.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/asm-generic/cputime_jiffies.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/sem.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/uapi/linux/sem.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/ipc.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/uapi/linux/ipc.h \
  arch/arm64/include/generated/asm/ipcbuf.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/uapi/asm-generic/ipcbuf.h \
  arch/arm64/include/generated/asm/sembuf.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/uapi/asm-generic/sembuf.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/shm.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/uapi/linux/shm.h \
  arch/arm64/include/generated/asm/shmbuf.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/uapi/asm-generic/shmbuf.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/asm/shmparam.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/uapi/asm-generic/shmparam.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/signal.h \
    $(wildcard include/config/old/sigaction.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/uapi/linux/signal.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/uapi/asm/signal.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/asm-generic/signal.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/uapi/asm-generic/signal.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/uapi/asm-generic/signal-defs.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/uapi/asm/sigcontext.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/uapi/asm/siginfo.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/asm-generic/siginfo.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/uapi/asm-generic/siginfo.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/pid.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/topology.h \
    $(wildcard include/config/use/percpu/numa/node/id.h) \
    $(wildcard include/config/have/memoryless/nodes.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/mmzone.h \
    $(wildcard include/config/force/max/zoneorder.h) \
    $(wildcard include/config/cma.h) \
    $(wildcard include/config/memory/isolation.h) \
    $(wildcard include/config/zsmalloc.h) \
    $(wildcard include/config/zone/dma.h) \
    $(wildcard include/config/zone/dma32.h) \
    $(wildcard include/config/zone/device.h) \
    $(wildcard include/config/flat/node/mem/map.h) \
    $(wildcard include/config/page/extension.h) \
    $(wildcard include/config/no/bootmem.h) \
    $(wildcard include/config/deferred/struct/page/init.h) \
    $(wildcard include/config/need/multiple/nodes.h) \
    $(wildcard include/config/have/memory/present.h) \
    $(wildcard include/config/need/node/memmap/size.h) \
    $(wildcard include/config/have/memblock/node/map.h) \
    $(wildcard include/config/have/arch/early/pfn/to/nid.h) \
    $(wildcard include/config/sparsemem/extreme.h) \
    $(wildcard include/config/holes/in/zone.h) \
    $(wildcard include/config/arch/has/holes/memorymodel.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/pageblock-flags.h \
    $(wildcard include/config/hugetlb/page/size/variable.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/memory_hotplug.h \
    $(wildcard include/config/have/arch/nodedata/extension.h) \
    $(wildcard include/config/arch/has/add/pages.h) \
    $(wildcard include/config/have/bootmem/info/node.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/notifier.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/mutex.h \
    $(wildcard include/config/mutex/spin/on/owner.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/srcu.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/asm/topology.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/asm-generic/topology.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/seccomp.h \
    $(wildcard include/config/seccomp.h) \
    $(wildcard include/config/have/arch/seccomp/filter.h) \
    $(wildcard include/config/seccomp/filter.h) \
    $(wildcard include/config/checkpoint/restore.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/uapi/linux/seccomp.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/asm/seccomp.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/asm/unistd.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/uapi/asm/unistd.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/asm-generic/unistd.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/uapi/asm-generic/unistd.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/asm-generic/seccomp.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/uapi/linux/unistd.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/rculist.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/rtmutex.h \
    $(wildcard include/config/debug/rt/mutexes.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/resource.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/uapi/linux/resource.h \
  arch/arm64/include/generated/asm/resource.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/asm-generic/resource.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/uapi/asm-generic/resource.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/hrtimer.h \
    $(wildcard include/config/high/res/timers.h) \
    $(wildcard include/config/time/low/res.h) \
    $(wildcard include/config/timerfd.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/timerqueue.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/kcov.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/uapi/linux/kcov.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/task_io_accounting.h \
    $(wildcard include/config/task/io/accounting.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/latencytop.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/cred.h \
    $(wildcard include/config/debug/credentials.h) \
    $(wildcard include/config/security.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/key.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/assoc_array.h \
    $(wildcard include/config/associative/array.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/selinux.h \
    $(wildcard include/config/security/selinux.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/gfp.h \
    $(wildcard include/config/pm/sleep.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/uapi/linux/magic.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/cgroup-defs.h \
    $(wildcard include/config/sock/cgroup/data.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/uapi/linux/limits.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/idr.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/percpu-refcount.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/percpu-rwsem.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/rcu_sync.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/bpf-cgroup.h \
    $(wildcard include/config/cgroup/bpf.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/uapi/linux/bpf.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/uapi/linux/bpf_common.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/cgroup_subsys.h \
    $(wildcard include/config/cgroup/cpuacct.h) \
    $(wildcard include/config/blk/cgroup.h) \
    $(wildcard include/config/cgroup/device.h) \
    $(wildcard include/config/cgroup/freezer.h) \
    $(wildcard include/config/cgroup/net/classid.h) \
    $(wildcard include/config/cgroup/perf.h) \
    $(wildcard include/config/cgroup/net/prio.h) \
    $(wildcard include/config/cgroup/hugetlb.h) \
    $(wildcard include/config/cgroup/pids.h) \
    $(wildcard include/config/cgroup/debug.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/uapi/linux/stat.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/kmod.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/elf.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/asm/elf.h \
  arch/arm64/include/generated/asm/user.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/asm-generic/user.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/uapi/linux/elf.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/uapi/linux/elf-em.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/kobject.h \
    $(wildcard include/config/uevent/helper.h) \
    $(wildcard include/config/debug/kobject/release.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/sysfs.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/kernfs.h \
    $(wildcard include/config/kernfs.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/kobject_ns.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/kref.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/moduleparam.h \
    $(wildcard include/config/alpha.h) \
    $(wildcard include/config/ia64.h) \
    $(wildcard include/config/ppc64.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/extable.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/rbtree_latch.h \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/linux/cfi.h \
    $(wildcard include/config/cfi/clang/shadow.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/arch/arm64/include/asm/module.h \
    $(wildcard include/config/arm64/module/plts.h) \
    $(wildcard include/config/randomize/base.h) \
  /home/henley/cross/Linux_for_Tegra/source/public/kernel/kernel-4.9/include/asm-generic/module.h \
    $(wildcard include/config/have/mod/arch/specific.h) \
    $(wildcard include/config/modules/use/elf/rel.h) \
    $(wildcard include/config/modules/use/elf/rela.h) \

/home/henley/adacore/repos/adacore_jetson/tmp/basic_kernel_module.o: $(deps_/home/henley/adacore/repos/adacore_jetson/tmp/basic_kernel_module.o)

$(deps_/home/henley/adacore/repos/adacore_jetson/tmp/basic_kernel_module.o):
