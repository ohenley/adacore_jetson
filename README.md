# AdaCore Jetson

NVIDIA Jetson Nano LED Linux driver experiment in Ada

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
>  - Second controls by direct read/write to the GPIO memory registers using kernel mapped memory IO interface (`include/asm-generic/io.h`).       

## Status
Both flavors of the LED interface implementation are working. Both cross and native build are working.
- Working : GNAT Pro 23.0w cross toolchain  ("toolchain_type" : "cross")
- Working : Jetson Ubuntu 18.04, GNAT 7.5.0 ("toolchain_type" : "native")

## Prerequisites
- NVIDIA Jetson Nano Developer Kit.
- Complete led circuit. Bill of Material, eg. https://www.sparkfun.com/
   - 1x resistor kit: __COM-10969__    
   - 1x LED: __COM-11372__    
   - 1x BC337 transistor: __COM-13689__    
   - 1x breadboard: __PRT-12615__    
   - 1x jumper wires kit: __PRT-09140__    

```
+5V o----------jumper wire-----------o
                                     |
                                    .-.
                                    | | 560
                                    '-'
                                     |
                                     |
                               LED  \ /         
                                     V -->
                                    ---
                                     |
                                     |
                                   |/
Pin 18 o-------jumper wire---------|  BC337
                                   |>
                                     |
                                     |
                                     |
GND o----------jumper wire-----------o 
```

<br/><br/>
<div align="center">
	<img width=800px"  src="https://github.com/ohenley/files/blob/master/circuit.png" alt="Awesome">
</div>

<br><br>

## Dependencies
- Python 3.x on host machine.    
#### Cross
- GNAT Pro 23 cross compilation toolchain on host machine.     
(see https://github.com/ohenley/adacore_jetson/blob/main/jetson_nano_modules_cross.md for further details on how to setup)   
#### Native
- Jetson Ubuntu 18.04, GNAT 7.5.0.     
(see https://github.com/ohenley/adacore_jetson/blob/main/jetson_nano_modules_native.md for further details on how to setup) 

## Building
#### Linux
- Set the absolute path value for both `kernel_sources_abspath` and `cross_toolchain_abspath` keys found in file `flash_led_jetson_nano.json`
- Issue the following at __host__ cmd: 
```
$ python3 make.py generate config:flash_led_jetson_nano.json
$ python3 make.py build config:flash_led_jetson_nano.json rts:true
```

## Installation
- Replace xyz.xyz.xyz.xyz by your jetson ip address and issue the following at __host__ cmd:
```
$ scp flash_led/flash_led.ko your_jetson_username@xyz.xyz.xyz.xyz:~ ; ssh your_jetson_username@xyz.xyz.xyz.xyz
```

## Limitations
Do not hesitate to fill a Github issue if you find any problem.

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


