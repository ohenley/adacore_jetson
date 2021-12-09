#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <asm/io.h>

MODULE_LICENSE("GPL");

int init_module(void){
    printk(KERN_INFO "fuck you IN"); 

    void __iomem* membase;
    uint32_t phys_addr = 0x6000d000;
    uint32_t size = 0x0ff;

    membase = ioremap(phys_addr, size);

    uint32_t i = 0;
    for(; i <= 0xff; i=i+4){
        uint32_t value = ioread32(membase+i);
        printk("%02X", value);
    }

    return 0;
}
void cleanup_module(void){
    printk(KERN_INFO "fuck you OUT");
}