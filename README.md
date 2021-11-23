# AdaCore Jetson

Ada Linux Modules for the Nvidia Jetson-Nano

## Table of Contents
<details>
<summary>Click to expand</summary>

1. [About](#About)
2. [Status](#Status)
3. [Prerequisites](#Prerequisites)  
4. [Dependencies](#Dependencies)
5. [Building](#Building)
   1. [Windows](#Windows)
   2. [Other OSes](#Other-OSes)
6. [Installation](#Installation)
7. [Limitations](#Limitations)
8. [Usage](#Usage)
9. [Acknowledgments](#Acknowledgments)

</details>

## About

> Not "that" trivial linux modules tutorial written in the Ada programming language  
> Targeted at the Arm based Nvidia Jetson-Nano board running Ubuntu 18.04 

## Status
flash a led --> working

## Prerequisites
- x86_64 Linux running on target board.
- Python 3.x on host.
- GNAT cross compilation toolchain on host machine. (see jetson_nano_cross_compilation.md for further details on how to setup)
- Complete led circuit with transistor base connected to physical board pin 13. (linux equivalent internal mapping: gpio #14)  
![alt text](https://i.stack.imgur.com/2vrSj.gif)

## Dependencies
- None

## Building
#### Linux
- Set the absolute path value for both `kernel_sources_abspath` and `cross_toolchain_abspath` keys found in file `flash_led_jetson_nano.json`
- Issue the following at host cmd: 
```
$ python make.py generate config:flash_led_jetson_nano.json
$ python make.py build config:flash_led_jetson_nano.json rts:true
```

## Installation
- Replace xxx.xxx.xxx.xxx by your jetson ip address and issue the following at host cmd:
```
$ scp flash_led/flash_led.ko your_jetson_username@xxx.xxx.xxx.xxx:~ ; ssh your_jetson_username@xxx.xxx.xxx.xxx
```

## Limitations
None

## Usage
- Issue the following at target cmd to insert kernel module: 
```
jetson:~$ sudo insmod flash_led.ko
```
- Your led should now flash at ~1Hz. now to remove kernel module:
```
jetson:~$ sudo rmmod flash_led.ko
```

## Acknowledgments
Thanks to Quentin Ochem, Nicolas Setton, Fabien Chouteau, Jerome Lambourg, Michael Frank and Derek Schacht. 


