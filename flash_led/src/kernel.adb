with ada.Unchecked_Conversion;
package body kernel is

    function to_result (res : s32) return result is
    begin
        if res = 0 then
            return success;
        end if;
        return error;
    end;

    function to_led_state is new Ada.Unchecked_Conversion (Source => s32, Target => led.state);
    function to_s32 is new Ada.Unchecked_Conversion (Source => led.state, Target => s32);

    -- debug

    procedure resolved_printk( s : string ) with
        import        => true,
        convention    => c,
        external_name => "printk";

    procedure print (s : string) is
    begin
        resolved_printk (s & ascii.lf & ascii.nul);
    end;

    -- gpio

    type gpio_desc_acc is new system.address;

    function gpio_to_desc (gpio : u32) return gpio_desc_acc with
        import        => true,
        convention    => c,
        external_name => "gpio_to_desc";

    function resolved_gpiod_direction_output_raw (desc : gpio_desc_acc; value : s32) return s32 with
        import        => true,
        convention    => c,
        external_name => "gpiod_direction_output_raw";

    function resolved_gpiod_get_raw_value (desc : gpio_desc_acc) return s32 with
        import        => true,
        convention    => c,
        external_name => "gpiod_get_raw_value";

    function resolved_gpio_request (gpio : u32; label : string) return s32 with
        import        => true,
        convention    => c,
        external_name => "gpio_request";

    function gpio_request (gpio : u32; label : string) return result is
    begin
        return to_result(resolved_gpio_request (gpio, label & ascii.lf & ascii.nul));
    end;

    function gpio_direction_output (gpio : u32; state : led.state) return result is
        desc : gpio_desc_acc := gpio_to_desc (gpio);
        use led;
    begin
        if state = high then
            return to_result(resolved_gpiod_direction_output_raw (desc, 1));
        else
            return to_result(resolved_gpiod_direction_output_raw (desc, 0));
        end if;
    end;

    function gpio_get_value (gpio : u32) return led.state is
        desc : gpio_desc_acc := gpio_to_desc (gpio);
    begin
        return to_led_state(resolved_gpiod_get_raw_value (desc));
    end;

    procedure resolved_init_timer_key (timer : access timer_list; 
                                       flags : u32;
                                       name  : string; 
                                       key   : system.address) with
        import        => true,
        convention    => c,
        external_name => "init_timer_key";

    procedure init_timer_key (timer : access timer_list; 
                              flags : u32;
                              name  : string; 
                              key   : system.address) is
    begin
        resolved_init_timer_key (timer, flags, name & ascii.lf & ascii.nul, key);
    end;

    function resolved_del_timer (timer : access timer_list) return s32 with
        import        => true,
        convention    => c,
        external_name => "del_timer";

    function del_timer (timer : access timer_list) return result is
    begin
        return to_result(resolved_del_timer (timer));
    end;

    function resolved_ioremap (phys_addr : system.Address; size : u32; pgprot : u64) return system.Address with
        import        => true,
        convention    => c,
        external_name => "__ioremap";

    function ioremap (phys_addr : system.Address; size : u32) return system.Address is
        pgprot : u64 := 16#00e8000000000707#;
    begin
        return resolved_ioremap(phys_addr, size, pgprot);
    end;

    procedure resolved_queue_delayed_work (cpu : ic.int; 
                                            wq : workqueue_struct_access;
                                            work : delayed_work_access;
                                            delayy : u64) with
        import        => true,
        convention    => c,
        external_name => "queue_delayed_work_on";

    procedure queue_delayed_work (wq : workqueue_struct_access;
                                  work : delayed_work_access;
                                  delayy : u64) is
    begin
        resolved_queue_delayed_work (1, wq, work, delayy);
    end;


    function resolved_alloc_workqueue_key (format: string; 
                                           flags: ic.unsigned; 
                                           max_active : ic.int;
                                           lock_class_key : system.address;
                                           lock_name : system.address; 
                                           name : string) return workqueue_struct_access with
        import        => true,
        convention    => c,
        external_name => "__alloc_workqueue_key";

    function alloc_workqueue (name : string) return workqueue_struct_access is
    begin
        return resolved_alloc_workqueue_key ("%s", 16#E000A#, 1, system.null_address, system.null_address, name);
    end;


end kernel;
