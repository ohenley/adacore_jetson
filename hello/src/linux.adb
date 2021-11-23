package body linux is

    -- debug

    procedure resolved_printk( s : string ) with
        Import        => True,
        Convention    => C,
        External_Name => "printk";

    procedure Printk (s : String) is
    begin
        resolved_printk (s & ASCII.LF & ASCII.NUL);
    end;

    -- gpio

    type gpio_desc_acc is new system.address;

    function gpio_to_desc (gpio : ic.Unsigned) return gpio_desc_acc with
        Import        => True,
        Convention    => C,
        External_Name => "gpio_to_desc";

    function gpiod_direction_output_raw
       (desc : gpio_desc_acc; value : ic.Int) return ic.int with
        Import        => True,
        Convention    => C,
        External_Name => "gpiod_direction_output_raw";

    procedure gpiod_set_raw_value (desc : gpio_desc_acc; value : ic.Int) with
        Import        => True,
        Convention    => C,
        External_Name => "gpiod_set_raw_value";

    function gpiod_get_raw_value (desc : gpio_desc_acc) return ic.Int with
        Import        => True,
        Convention    => C,
        External_Name => "gpiod_get_raw_value";

    function Gpio_Direction_Output (Gpio : ic.Unsigned; Value : ic.Int) return ic.Int
    is
        desc : gpio_desc_acc := gpio_to_desc (Gpio);
    begin
        return gpiod_direction_output_raw (desc, ic.Int (value));
    end;

    procedure Gpio_Set_Value (Gpio : ic.Unsigned; Value : ic.Int) is
        desc : gpio_desc_acc := gpio_to_desc (Gpio);
    begin
        gpiod_set_raw_value (desc, ic.Int (value));
    end;

    function Gpio_Get_Value (Gpio : ic.Unsigned) return ic.Int is
        desc : gpio_desc_acc := gpio_to_desc (Gpio);
    begin
        return gpiod_get_raw_value (desc);
    end;

end linux;
