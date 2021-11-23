# Ada Linux Modules for the Nvidia Jetson-Nano

The thug community chat application

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
<div align="center">

<a href="https://www.youtube.com/embed/yUqJkAZofZs">
<img border="0" src="https://img.youtube.com/vi/yUqJkAZofZs/1.jpg" style="max-width:100%;">
</a>
  
<a href="https://www.youtube.com/embed/3e-BGblAMC4">
<img border="0" src="https://img.youtube.com/vi/3e-BGblAMC4/2.jpg" style="max-width:100%;">	
</a>
  
<a href="https://www.youtube.com/embed/0yXwnk8Cr0c">
<img border="0" src="https://img.youtube.com/vi/0yXwnk8Cr0c/3.jpg" style="max-width:100%;">
</a>
   
</div>

> your street creds can now be voted up/down by peers.  
> every 'he' occurences are replaced by 'thug'.

<!---![alt text](https://github.com/ohenley/readme-template/blob/master/thug_war.png)--->

## Status
Linux support: WIP

## Prerequisites
- Win32 platform
- Gnat compiler

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


