#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>

MODULE_LICENSE("GPL");

int init_module(void){
    printk(KERN_INFO "Hello world 1."); 
    return 0;
}
void cleanup_module(void){
    printk(KERN_INFO "Goodbye world 1.");
}