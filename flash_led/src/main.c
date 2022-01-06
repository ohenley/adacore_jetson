#ifndef _LINUX_CORE_
#define _LINUX_CORE_

#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>
//#include <linux/io.h>
//#include <linux/mm.h>
//#include <asm/io.h>
//#include <asm/pgtable-hwdef.h>
//#include <asm/pgtable-prot.h>
//#include <asm/page.h>
//#include <asm-generic/bug.h>
//#include <linux/compiler.h>

extern void ada_init_module (void);
extern void ada_cleanup_module (void);

int init_module(void)
{
    ada_init_module();
    return 0;
}

void cleanup_module(void)
{
    ada_cleanup_module();
}

void print_hex(u32 value)
{
    printk("%02X", value);
}

void print_access_hex(u64* value)
{
    printk("%p\n", value);
}

MODULE_LICENSE("GPL");

#endif /* _LINUX_CORE_ */