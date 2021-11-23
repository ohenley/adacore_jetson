obj-m := hello.o
hello-y := obj/bundle.o

all:
	make ARCH=arm64 CROSS_COMPILE=/home/henley/adacore/e3-20211024/wave/aarch64-linux-linux64/gnat/install/bin/aarch64-linux-gnu- -C /home/henley/cross/output M=/home/henley/adacore/repos/adacore_jetson/./hello modules
