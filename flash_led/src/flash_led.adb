with system;
with kernel; use kernel;
with led; use led;
with led.device; use led.device;

package body flash_led is

    timer : aliased kernel.timer_list;
    half_period_ms : kernel.u32 := 500;

    --my_led : led_type; -- problem

    my_led : constant led_type := (pin_nbr => 14, 
                                   label   => "my_led"); -- no problem
    
    procedure timer_callback (unused : kernel.u32) with convention => c;
    procedure timer_callback (unused : kernel.u32) is
    begin
        light (my_led, not get_state (my_led));
        timer.expires := kernel.jiffies + kernel.msecs_to_jiffies (half_period_ms);
        kernel.add_timer (timer'access);
    end;

    procedure setup_timer is
    begin
        kernel.init_timer_key (timer'access, 0, "gpio_timer", system.null_address);
        timer.c_function := timer_callback'access;
        timer.data       := 0;
        timer.expires := kernel.jiffies + kernel.msecs_to_jiffies (half_period_ms);
        kernel.add_timer (timer'access);
    end;

    procedure ada_init_module is
        procedure ada_linux_init with
            import        => true,
            convention    => ada,
            external_name => "flash_ledinit";  
    begin
        ada_linux_init;
        init (my_led);
        setup_timer;
    end;

    procedure ada_cleanup_module is
        res     : kernel.result;
    begin
        res := kernel.del_timer (timer'access);
        deinit(my_led);
    end;

end flash_led;
