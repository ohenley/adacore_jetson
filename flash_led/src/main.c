#ifndef _LINUX_CORE_
#define _LINUX_CORE_

#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/io.h>
#include <linux/mm.h>
#include <asm/io.h>
#include <asm/pgtable-hwdef.h>
#include <asm/pgtable-prot.h>
#include <asm/page.h>
#include <asm-generic/bug.h>
#include <linux/compiler.h>


extern void ada_init_module (void);
extern void ada_cleanup_module (void);
extern void ada_write_assembly (u32 value, u64* addr);

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

//void my_iowrite32(u64* addr, u32 value){
//
//    printk("%p\n", addr);
//    //printk("%02X", value);
//
//
//    /*void __iomem* membase;
//    uint32_t phys_addr = 0x70003000;
//    uint32_t offset = 0x6C;
//
//    membase = ioremap(phys_addr + offset, 4);
//    printk("%02X", membase);*/
//
//    /*asm volatile ( "dsb st\n\t"
//    "str %w0, [%1]"
//                   :
//                   : "rZ" (value), "r" (addr)
//                   : "memory");*/
//
//
//    asm volatile ("dsb st" : : : "memory");
//    asm volatile ("str %w0, [%1]" 
//    : 
//    : "rZ" (value), "r" (addr));
//}


//static void __iomem* my_ioremap_caller(phys_addr_t phys_addr, size_t size, pgprot_t prot, void *caller)
//{
//    unsigned long last_addr;
//	unsigned long offset = phys_addr & ~PAGE_MASK;
//	int err;
//	unsigned long addr;
//	struct vm_struct *area;
//
//	/*
//	 * Page align the mapping address and size, taking account of any
//	 * offset.
//	 */
//	phys_addr &= PAGE_MASK;
//	size = PAGE_ALIGN(size + offset);
//
//	/*
//	 * Don't allow wraparound, zero size or outside PHYS_MASK.
//	 */
//	last_addr = phys_addr + size - 1;
//	if (!size || last_addr < phys_addr || (last_addr & ~PHYS_MASK))
//		return NULL;
//
//	/*
//	 * Don't allow RAM to be mapped.
//	 */
//	if (WARN_ON(pfn_valid(__phys_to_pfn(phys_addr))))
//		return NULL;
//
//	area = get_vm_area_caller(size, VM_IOREMAP, caller);
//	if (!area)
//		return NULL;
//	addr = (unsigned long)area->addr;
//	area->phys_addr = phys_addr;
//
//	err = ioremap_page_range(addr, addr + size, phys_addr, prot);
//	if (err) {
//		vunmap((void *)addr);
//		return NULL;
//	}
//
//	return (void __iomem *)(offset + addr);
//}
//
//void __iomem* my_ioremap(phys_addr_t phys_addr, size_t size, pgprot_t prot)
//{
//	return my_ioremap_caller(phys_addr, size, prot,
//				__builtin_return_address(0));
//}
//
//u64* my_ioremap_wrapper(u64* addr, u32 size) {
//    phys_addr_t a = addr;
//    return my_ioremap(a, size, __pgprot(PROT_DEVICE_nGnRE));
//}

//u64* my_ioremap_wrapper(u64* addr, u32 size) {
//    printk("%p\n", PROT_DEVICE_nGnRE);
//    printk("%llu\n",PROT_DEVICE_nGnRE);
//    printk("%p\n", __pgprot(PROT_DEVICE_nGnRE));
//    printk("%llu\n",__pgprot(PROT_DEVICE_nGnRE));
//
//    return __ioremap(addr, size, __pgprot(PROT_DEVICE_nGnRE));
//}
//
//void do_mux(void){
//    void __iomem* membase;
//    uint32_t phys_addr = 0x70003000;
//    uint32_t offset = 0x6C;
//
//    membase = ioremap(phys_addr + offset, 4);
//    //ada_write_assembly (0x0, membase);
//    my_iowrite32(membase, 0x0);
//}
//
//void do_gpio(void){
//    void __iomem* membase;
//    uint32_t phys_addr = 0x6000d000;
//    uint32_t offset = 0x004;
//
//    membase = ioremap(phys_addr + offset, 4);
//    //ada_write_assembly (0x40, membase);
//    my_iowrite32(membase, 0x40);
//
//    offset = 0x014;
//    membase = ioremap(phys_addr + offset, 4);
//    //ada_write_assembly (0x40, membase);
//    my_iowrite32(membase, 0x40);
//
//    offset = 0x024;
//    membase = ioremap(phys_addr + offset, 4);
//    //ada_write_assembly (0x40, membase);
//    my_iowrite32(membase, 0x40);
//}



MODULE_LICENSE("GPL");


#endif /* _LINUX_CORE_ */