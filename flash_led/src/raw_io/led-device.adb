package body led.device is

    procedure init (l : led_type) is
        use kernel;
        phys_addr : kernel.u32 := 16#6000d000#;
        addr_offset : kernel.u32 := 16#6C#;
        size : kernel.u32 := 16#0ff#;

        first_addr : kernel.u32 := kernel.ioremap_cache (phys_addr+addr_offset, size);
        --second_addr : kernel.u32 := kernel.early_ioremap (phys_addr, size);
    begin
        kernel.print(first_addr'image);
        --kernel.print(second_addr'image);
    end;

    procedure light (l : led_type; s : state) is

    begin
        null;
    end;

    function get_state (l : led_type) return state is
    begin
        return high;
    end;

    procedure deinit (l : led_type) is
    begin
        null;
    end;

end led.device;