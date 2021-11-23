package body linux is

    -- debug

    procedure resolved_printk( s : string ) with
        import        => true,
        convention    => c,
        external_name => "printk";

    procedure printk (s : string) is
    begin
        resolved_printk (s & ascii.lf & ascii.nul);
    end;

    -- gpio

    type gpio_desc_acc is new system.address;

    function gpio_to_desc (gpio : ic.unsigned) return gpio_desc_acc with
        import        => true,
        convention    => c,
        external_name => "gpio_to_desc";

    function gpiod_direction_output_raw
       (desc : gpio_desc_acc; value : ic.int) return ic.int with
        import        => true,
        convention    => c,
        external_name => "gpiod_direction_output_raw";

    procedure gpiod_set_raw_value (desc : gpio_desc_acc; value : ic.int) with
        import        => true,
        convention    => c,
        external_name => "gpiod_set_raw_value";

    function gpiod_get_raw_value (desc : gpio_desc_acc) return ic.int with
        import        => true,
        convention    => c,
        external_name => "gpiod_get_raw_value";

    function gpio_direction_output (gpio : ic.unsigned; value : ic.int) return ic.int is
        desc : gpio_desc_acc := gpio_to_desc (gpio);
    begin
        return gpiod_direction_output_raw (desc, ic.int (value));
    end;

    procedure gpio_set_value (gpio : ic.unsigned; value : ic.int) is
        desc : gpio_desc_acc := gpio_to_desc (gpio);
    begin
        gpiod_set_raw_value (desc, ic.int (value));
    end;

    function gpio_get_value (gpio : ic.unsigned) return ic.int is
        desc : gpio_desc_acc := gpio_to_desc (gpio);
    begin
        return gpiod_get_raw_value (desc);
    end;

end linux;
