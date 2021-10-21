sudo apt install git bc bison flex libssl-dev make libc6-dev libncurses5-dev

git clone --depth=1 https://github.com/raspberrypi/linux

update config.json to point source to the `linux` repo

export KERNEL=kernel7l

export PATH=~/wave/x86_64-linux/gnat/install/bin:$PATH
#export PATH=~/wave/aarch64-linux-linux64/gnat/install/bin:$PATH
export ENV_PREFIX=/home/henley/wave/aarch64-linux-linux64/gnat/install/bin

make ARCH=arm CROSS_COMPILE=/home/henley/wave/armhf-linux-linux64/gnat/install/bin/arm-linux-gnueabihf- -C /home/henley/adacore/repos/cross/linux bcm2711_defconfig ----> will generate the .config

make ARCH=arm CROSS_COMPILE=/home/henley/wave/armhf-linux-linux64/gnat/install/bin/arm-linux-gnueabihf- -C /home/henley/adacore/repos/cross/linux modules_prepare


cmd_/home/henley/adacore/repos/incremental_ada_linux_driver/tmp/basic_kernel_module.ko := /home/henley/wave/armhf-linux-linux64/gnat/install/bin/arm-linux-gnueabihf-ld -r  -EL  --build-id=sha1  -T scripts/module.lds -o /home/henley/adacore/repos/incremental_ada_linux_driver/tmp/basic_kernel_module.ko /home/henley/adacore/repos/incremental_ada_linux_driver/tmp/basic_kernel_module.o /home/henley/adacore/repos/incremental_ada_linux_driver/tmp/basic_kernel_module.mod.o;  true
