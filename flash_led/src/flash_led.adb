with system;
with kernel; use kernel;

package body flash_led is

    led_timer : aliased kernel.timer_list;
    gpio : kernel.u32 := 14;
    half_period_ms : kernel.u32 := 500;

    procedure timer_callback (unused : kernel.u32) with convention => c;
    procedure timer_callback (unused : kernel.u32) is
        use kernel.led; 
        res  : kernel.result;
    begin
        if kernel.gpio_get_value (gpio) = kernel.led.low then
            res := kernel.gpio_direction_output (gpio, kernel.led.high);
        else
            res := kernel.gpio_direction_output (gpio, kernel.led.low);
        end if;
        led_timer.expires := kernel.jiffies + kernel.msecs_to_jiffies (half_period_ms);
        kernel.add_timer (led_timer'access);
    end;

    procedure setup_timer is
        name : string := "gpio_timer";
    begin
        kernel.init_timer_key (led_timer'access, 0, name, system.null_address);
        led_timer.c_function := timer_callback'access;
        led_timer.data       := 0;
        led_timer.expires := kernel.jiffies + kernel.msecs_to_jiffies (half_period_ms);
        kernel.add_timer (led_timer'access);
    end;

    procedure ada_init_module is
        procedure ada_linux_init with
            import        => true,
            convention    => ada,
            external_name => "flash_ledinit";  
    begin
        ada_linux_init;
        declare
            use kernel.led;
            res  : kernel.result;
            label : string := "gpio14";
        begin
            res := kernel.gpio_request (gpio, label);
            setup_timer;
        end;
    end;

    procedure ada_cleanup_module is
        res     : kernel.result;
    begin
        res := kernel.del_timer (led_timer'access);
        kernel.gpio_free (gpio);
    end;

end flash_led;
