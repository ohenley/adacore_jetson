## Cross compilation from HOST(linux x86_64) to TARGET(linux aarch64) kernel module for the NVIDIA Jetson Nano

1. The Jetson host OS, based on Ubuntu 18.04, needs to be up and running (install, boot, login directly or ssh remotely). Please follow these [steps](https://developer.nvidia.com/embedded/learn/get-started-jetson-nano-devkit) if such Linux install is not done yet and therefore you cannot boot on the Jetson like an usual workstation. We have informations to gather from it. Once ready, natively boot the Jetson board and find it's network address: 
```
hostname -I | awk '{print $1}'
```

2. From now on we will access the Jetson remotely using the network address just found. Connect to the remote/**target** Jetson board from your local machine/**host**, eg using ssh:    
```
ssh my_jetson_username@192.168.xyz.xyz
```

3. Check the Jetson version. On the remote/**target** Jetson platform, execute and note aside:    
```
jetson:~$ cat /etc/nv_tegra_release
# R32 (release), REVISION: 6.1, GCID: 27863751, BOARD: t210ref, EABI: aarch64, DATE: Mon Jul 26 19:20:30 UTC 2021
```

4. Go back to the host machine. Unpack the **aarch64-linux-linux64** (from AdaCore download page: https://gt3-int-prod-1.adacore.com/#/downloads) cross toolchain somewhere. Note the path of its cross binaries location, eg. unpacking `GNAT Pro` on my machine/**host** at `~/Downloads/gnat-22.1` the binaries end up at
`~/Downloads/gnat-22.1/gnatpro-22.1-aarch64-linux-linux64-bin/bin`


5. On the local machine/**host** create a base folder for the cross compilation and kernel output folder, eg. `~/cross_base` and move to it.     
```
mkdir ~/cross_base
mkdir ~/cross_base/output
cd ~/cross_base
```

6. Get the linux sources, **Linux for Tegra (L4T)** (from NVIDIA download page: https://developer.nvidia.com/embedded/downloads)
eg. from the output at 2. I download the **kernel sources** identified as **L4T Driver Package (BSP) Sources 32.6.1** and rename for our context.     
```
wget https://developer.nvidia.com/embedded/l4t/r32_release_v6.1/sources/t210/public_sources.tbz2 -O tegra_sources.archive
```

7. Extract sources, eg. (will create `Linux_for_Tegra` folder):       
```
tar -xvf tegra_sources.archive
```

8. Unpack the kernel sources:       
```
tar -xjf ~/cross_base/Linux_for_Tegra/source/public/kernel_src.tbz2
```

9. From remote/**target** Jetson command prompt, download its original kernel config to local machine/**host**, eg (xyz.xyz.xyz.xyz being the address of my local machine/**host**):    
```
jetson:~$ sudo scp /proc/config.gz my_local_username@192.168.xyz.xyz:~/cross_base/output
```

10. Extract the config.gz content to .config file:        
```
gzip -d -c ~/cross_base/output/config.gz > ~/cross_base/output/.config
```

11. Set ENV_PREFIX, eg. using `GNAT PRO` binaries on my machine/**host** it becomes:
```
export ENV_PREFIX="~/Downloads/gnat-22.1/gnatpro-22.1-aarch64-linux-linux64-bin/bin"
```

12. Prepare the modules, eg:    
```
make ARCH=arm64 CROSS_COMPILE=~/Downloads/gnat-22.1/gnatpro-22.1-aarch64-linux-linux64-bin/bin/aarch64-linux-gnu- O=~/cross_base/output -C ~/cross_base/kernel/kernel-4.9 modules_prepare
```

13. Set "kernel_sources_abspath" in flash_led_jetson_nano.json, eg.
```
...
"kernel_sources_abspath" : "~/cross_base/output",
...
```

14. Set "toolchain_type" in flash_led_jetson_nano.json, eg.
```
...
"toolchain_type" : "cross",
...
```

15. Set "toolchain_abspath" in flash_led_jetson_nano.json, eg.
```
...
"toolchain_abspath" : "~/Downloads/gnat-22.1/gnatpro-22.1-aarch64-linux-linux64-bin/bin",
...
```

