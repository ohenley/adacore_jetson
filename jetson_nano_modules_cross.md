## Cross compilation from HOST(linux x86_64) to TARGET(linux aarch64) kernel module for the NVIDIA Jetson Nano

1. The Jetson host OS, eg. Ubuntu 18.04, needs to be up and running (install, boot, login directly or ssh remotely). Please refer to NVIDIA documentation if such Linux install is not done yet. We have informations to gather from it, so login to the remote/**target** board, eg using ssh:    
```
ssh my_jetson_username@192.168.xyz.xyz
```

2. Check the Jetson version. On the remote/**target** Jetson platform, execute and note aside:    
```
jetson:~$ cat /etc/nv_tegra_release
# R32 (release), REVISION: 6.1, GCID: 27863751, BOARD: t210ref, EABI: aarch64, DATE: Mon Jul 26 19:20:30 UTC 2021
```

3. Go back to the host machine. From AdaCore, install the **aarch64-linux-linux64** cross toolchain. Note the path of its cross binaries location, eg. using `anod` will install it to something like `~/adacore/e3-20211024/wave/aarch64-linux-linux64/gnat/install/bin`     
```
anod install gnat --target=aarch64-linux
```

4. On the local machine/**host** create a base folder for the cross compilation and kernel output folder, eg. `~/cross_base` and move to it.     
```
mkdir ~/cross_base
mkdir ~/cross_base/output
cd ~/cross_base
```

5. Get the linux sources, **Linux for Tegra (L4T)** (from nvdia download page: https://developer.nvidia.com/embedded/downloads)
eg. from the output at 2. I download the **kernel sources** identified as **L4T Driver Package (BSP) Sources 32.6.1** and rename for our context.     
```
wget https://developer.nvidia.com/embedded/l4t/r32_release_v6.1/sources/t210/public_sources.tbz2 -O tegra_sources.archive
```

6. Extract sources, eg. (will create `Linux_for_Tegra` folder):       
```
tar -xvf tegra_sources.archive
```

7. Unpack the kernel sources:       
```
tar -xjf ~/cross_base/Linux_for_Tegra/source/public/kernel_src.tbz2
```

8. From remote/**target** Jetson command prompt, download its original kernel config to local machine/**host**, eg (xyz.xyz.xyz.xyz being the address of my local machine/**host**):    
```
jetson:~$ sudo scp /proc/config.gz my_local_username@192.168.xyz.xyz:~/cross_base/output
```

9. Extract the config.gz content to .config file:        
```
gzip -d -c ~/cross_base/output/config.gz > ~/cross_base/output/.config
```

10. Set ENV_PREFIX, eg. using `anod` will install it to something like `~/adacore/e3-20211024/wave/aarch64-linux-linux64/gnat/install/bin`:
```
export ENV_PREFIX="~/adacore/e3-20211024/wave/aarch64-linux-linux64/gnat/install/bin"
```

11. Prepare the modules, eg:    
```
make ARCH=arm64 CROSS_COMPILE=~/adacore/e3-20211024/wave/aarch64-linux-linux64/gnat/install/bin/aarch64-linux-gnu- O=~/cross_base/output -C ~/cross_base/kernel/kernel-4.9 modules_prepare
```

12. Set "kernel_sources_abspath" in flash_led_jetson_nano.json, eg.
```
...
"kernel_sources_abspath" : "~/cross_base/output",
...
```