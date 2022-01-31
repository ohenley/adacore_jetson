# AdaCore Jetson

NVIDIA jetson-nano LED driver experiment in Ada

## Table of Contents
<details>
<summary>Click to expand</summary>

1. [About](#About)
2. [Status](#Status)
3. [Prerequisites](#Prerequisites)  
4. [Dependencies](#Dependencies)
5. [Building](#Building)
   1. [Linux](#Linux)
6. [Installation](#Installation)
7. [Limitations](#Limitations)
8. [Usage](#Usage)
9. [Acknowledgments](#Acknowledgments)

</details>

## About

> Linux module experiment written in the Ada programming language.    
> Targeted at the NVIDIA Jetson-Nano board running Ubuntu 18.04 (aarch64, kernel-based v4.294).         
> It shows two implementations of a flashing LED interface:     
>  - First leverages the Linux GPIO interface (`include/linux/gpio.h`).    
>  - Second controls by direct read/write to the GPIO memory registers using kernel mapped memory (`ioremap`, `ioread32`, `iowrite32`).       

## Status
Both flavors of the LED interface implementation are working.

## Prerequisites
- Python 3.x on host machine.    
- GNAT cross compilation toolchain on host machine. (see `jetson_nano_cross_compilation.md` for further details on how to setup)     

## Dependencies
- NVIDIA Jetson Nano Developer Kit.
- Complete led circuit with transistor base connected to physical board pin 18.   
![alt text](https://i.stack.imgur.com/2vrSj.gif)

## Building
#### Linux
- Set the absolute path value for both `kernel_sources_abspath` and `cross_toolchain_abspath` keys found in file `flash_led_jetson_nano.json`
- Issue the following at __host__ cmd: 
```
$ python make.py generate config:flash_led_jetson_nano.json
$ python make.py build config:flash_led_jetson_nano.json rts:true
```

## Installation
- Replace xyz.xyz.xyz.xyz by your jetson ip address and issue the following at __host__ cmd:
```
$ scp flash_led/flash_led.ko your_jetson_username@xyz.xyz.xyz.xyz:~ ; ssh your_jetson_username@xyz.xyz.xyz.xyz
```

## Limitations
None. Do not hesitate to fill a Github issue if you find any problem.

## Usage
- Issue the following at __target__ cmd to insert kernel module: 
```
jetson:~$ sudo insmod flash_led.ko
```
- Your led should now flash at ~1Hz. now to remove kernel module:
```
jetson:~$ sudo rmmod flash_led.ko
```

## Acknowledgments
I want to thank Quentin Ochem, Nicolas Setton, Fabien Chouteau, Jerome Lambourg, Michael Frank, Derek Schacht, Arnaud Charlet, Pat Bernardi, Leo Germond, and Artium Nihamkin for their different insights and feedback to nail this experiment.


