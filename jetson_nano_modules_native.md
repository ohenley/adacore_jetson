## Compilation TARGET(linux aarch64) kernel module for the NVIDIA Jetson Nano

1. Install gnat   
```
$ sudo apt-get install gnat
```

2. On the local machine/**host** create a base folder for the cross compilation and kernel output folder, eg. `~/base` and move to it.     
```
$ mkdir ~/base
$ mkdir ~/base/output
$ cd ~/base
```

3. Get the linux sources, **Linux for Tegra (L4T)** (from nvdia download page: https://developer.nvidia.com/embedded/downloads)
eg. from the output at 2. I download the **kernel sources** identified as **L4T Driver Package (BSP) Sources 32.6.1** and rename for our context.     
```
$ wget https://developer.nvidia.com/embedded/l4t/r32_release_v6.1/sources/t210/public_sources.tbz2 -O tegra_sources.archive
```

4. Extract sources, eg. (will create `Linux_for_Tegra` folder):       
```
$ tar -xvf tegra_sources.archive
```

5. Unpack the kernel sources:       
```
$ tar -xjf ~/base/Linux_for_Tegra/source/public/kernel_src.tbz2
```

6. Copy original kernel config:    
```
$ sudo cp /proc/config.gz ~/cross_base/output/config.gz
```

7. Extract the config.gz content to .config file:    
```
$ gzip -d -c ~/base/output/config.gz > ~/base/output/.config
```

8. Prepare the modules, eg:    
```
$ make O=~/base/output -C ~/base/kernel/kernel-4.9 modules_prepare
```

9. Set "kernel_sources_abspath" in flash_led_jetson_nano.json, eg.
```
...
"kernel_sources_abspath" : "~/base/output",
...
```

10. Set "toolchain_type" in flash_led_jetson_nano.json, eg.
```
...
"toolchain_type" : "native",
...
```

11. Set "toolchain_abspath" in flash_led_jetson_nano.json, eg.
```
...
"toolchain_abspath" : "/usr/bin",
...
```