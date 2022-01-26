#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <asm/io.h>
#include <asm/pgtable-hwdef.h>
#include <asm/pgtable-prot.h>

MODULE_LICENSE("GPL");

void my_iowrite32(u32 value, u32* addr){
    asm volatile ("dsb st" : : : "memory");
    asm volatile("str %w0, [%1]" 
    : 
    : "rZ" (value), "r" (addr));
}

void do_mux(void){
    void __iomem* membase;
    uint32_t phys_addr = 0x70003000;
    uint32_t offset = 0x6C;

    membase = ioremap(phys_addr + offset, 4);
    my_iowrite32(0x0, membase);
}

void do_gpio(void){
    void __iomem* membase;
    uint32_t phys_addr = 0x6000d000;
    uint32_t offset = 0x004;

    membase = ioremap(phys_addr + offset, 4);
    my_iowrite32(0x40, membase);

    offset = 0x014;
    membase = ioremap(phys_addr + offset, 4);
    my_iowrite32(0x40, membase);

    offset = 0x024;
    membase = ioremap(phys_addr + offset, 4);
    my_iowrite32(0x40, membase);
}

int init_module(void){
    printk(KERN_INFO "IN"); 

    /*void __iomem* membase;
    uint32_t phys_addr = 0x70003000;
    uint32_t offset = 0x6C;

    membase = ioremap(phys_addr + offset, 4);
    my_iowrite32(0x0, membase);*/
    do_mux();

    /*phys_addr = 0x6000d000;
    offset = 0x004;
    membase = ioremap(phys_addr + offset, 4);
    my_iowrite32(0x40, membase);

    offset = 0x014;
    membase = ioremap(phys_addr + offset, 4);
    my_iowrite32(0x40, membase);

    offset = 0x024;
    membase = ioremap(phys_addr + offset, 4);
    my_iowrite32(0x40, membase);*/
    do_gpio();

    printk("iel!!!");


    //u64 pte_page = (u64)PTE_PROT_NONE;
    //printk("%02X", pte_page);

    // u64 prot_normal = (u64)PTE_WRITE;
    // printk("%02X", prot_normal);
    // printk("%llu", prot_normal);
    // printk("%u", prot_normal);
    // printk("%i", prot_normal);

    

    // uint32_t i = 0;
    // for(; i <= 0xff; i=i+4){
    //     uint32_t value = ioread32(membase+i);
    //     printk("%02X", value);
    // }

    return 0;
}
void cleanup_module(void){
    printk(KERN_INFO "OUT");
}