obj-m := hello.o
hello-y := obj/ada_linux.o obj/linux.o obj/linux_core.o

all:
	make ARCH=arm CROSS_COMPILE=/home/henley/wave/arm-elf-linux64/gnat/install/bin/arm-eabi- -C /home/henley/adacore/repos/cross/linux_rp32 M=/home/henley/adacore/repos/incremental_ada_linux_driver/./hello modules
