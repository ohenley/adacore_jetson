with system;
with interfaces.c; use interfaces.c;
with linux;

package body ada_linux is

    package IC renames interfaces.c;

    led_timer : aliased linux.Timer_List;
    gpio : ic.unsigned := 14;
    half_period_ms : ic.unsigned := 500;

    procedure timer_callback (data : ic.Unsigned_Long) with Convention => C;
    procedure timer_callback (data : ic.Unsigned_Long) is
        res  : IC.int;
    begin
        if linux.Gpio_Get_Value (gpio) = 0 then
            res := linux.Gpio_Direction_Output (gpio, 1);
        else
            res := linux.Gpio_Direction_Output (gpio, 0);
        end if;
        led_timer.Expires := linux.jiffies + linux.Msecs_To_Jiffies (half_period_ms);
        linux.Add_Timer (led_timer'access);
    end;

    procedure setup_timer is
        name : ic.char_array := "gpio_timer" & ic.nul;
    begin
        linux.Init_Timer_Key (led_timer'Access, 0, name, System.Null_Address);
        led_timer.C_Function := timer_callback'Access;
        led_timer.data       := 0;
        led_timer.Expires := linux.jiffies + linux.Msecs_To_Jiffies (half_period_ms);
        linux.Add_Timer (led_timer'access);
    end;

    procedure ada_init_module is
        procedure ada_linuxinit with
            Import        => True,
            Convention    => Ada,
            External_Name => "ada_linuxinit";
    begin
        ada_linuxinit;
        declare
            res  : IC.int;
            label : ic.char_array := "gpio14" & ic.nul;
        begin
            res := linux.gpio_request (gpio, label);
            res := linux.Gpio_Direction_Output (gpio, 0);
            setup_timer;
        end;
    end;

    procedure ada_cleanup_module is
        res     : IC.int;
    begin
        res := linux.del_timer (led_timer'Access);
        linux.Gpio_Free (gpio);
    end ;

end ada_linux;
