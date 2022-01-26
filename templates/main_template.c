#ifndef _LINUX_CORE_
#define _LINUX_CORE_

#include <linux/module.h>

int init_module(void)
{
    return 0;
}

void cleanup_module(void)
{
}

MODULE_LICENSE("GPL");

#endif /* _LINUX_CORE_ */