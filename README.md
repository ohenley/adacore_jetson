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

> not so trivial linux modules tutorial written in the Ada programming language  
> targeted at the Arm based Nvidia Jetson-Nano board running Ubuntu 18.04 

## Status
Working: flash a led 

## Prerequisites
- x86_64 Linux running on target board
- GNAT cross compilation toolchain on host machine (see jetson_nano_cross_compilation.md for further details on how to setup)
- led circuit    
![alt text](https://i.stack.imgur.com/2vrSj.gif)

## Dependencies
- Chat-Mania : https://github.com/ohenley/chat-mania

## Building
#### Windows
`$ git clone --recursive https://github.com/ohenley/twp.git`      
`$ gprbuild twp.gpr -Xplatform=win32`
   
#### Other OSes
- not supported yet

## Installation
- `$ whatever`

## Limitations
Only 3 consecutive messages are broadcast before being banned for the day.

## Usage
Launch twp.exe and chat with your thug community.

## Acknowledgments
Useage of Win95/NT console support (win32_cmd.ads/adb) provided by the King of Thugs. 


