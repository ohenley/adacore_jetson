with system;
with interfaces.c; use interfaces.c;
with linux;

package body ada_linux is

    package ic renames interfaces.c;

    led_timer : aliased linux.timer_list;
    gpio : ic.unsigned := 14;
    half_period_ms : ic.unsigned := 500;

    procedure timer_callback (data : ic.unsigned_long) with convention => c;
    procedure timer_callback (data : ic.unsigned_long) is
        res  : ic.int;
    begin
        if linux.gpio_get_value (gpio) = 0 then
            res := linux.gpio_direction_output (gpio, 1);
        else
            res := linux.gpio_direction_output (gpio, 0);
        end if;
        led_timer.expires := linux.jiffies + linux.msecs_to_jiffies (half_period_ms);
        linux.add_timer (led_timer'access);
    end;

    procedure setup_timer is
        name : ic.char_array := "gpio_timer" & ic.nul;
    begin
        linux.init_timer_key (led_timer'access, 0, name, system.null_address);
        led_timer.c_function := timer_callback'access;
        led_timer.data       := 0;
        led_timer.expires := linux.jiffies + linux.msecs_to_jiffies (half_period_ms);
        linux.add_timer (led_timer'access);
    end;

    procedure ada_init_module is
        procedure ada_linuxinit with
            import        => true,
            convention    => ada,
            external_name => "ada_linuxinit";
    begin
        ada_linuxinit;
        declare
            res  : ic.int;
            label : ic.char_array := "gpio14" & ic.nul;
        begin
            res := linux.gpio_request (gpio, label);
            res := linux.gpio_direction_output (gpio, 0);
            setup_timer;
        end;
    end;

    procedure ada_cleanup_module is
        res     : ic.int;
    begin
        res := linux.del_timer (led_timer'access);
        linux.gpio_free (gpio);
    end;

end ada_linux;
