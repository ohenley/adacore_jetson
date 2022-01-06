with kernel;
with System;
with led.device;
with Ada.Unchecked_Conversion;

with Interfaces; use Interfaces;

with System.Machine_Code;
with System.Storage_Elements;

with Controllers;
package body led.device is

    procedure io_write_32(val : kernel.u32; addr : system.Address) is
        use System.Machine_Code;
    begin
        asm (template => "dsb st", 
             Clobber => "memory",
             volatile => True);

        asm (template => "str %w0, [%1]", 
             inputs => (kernel.u32'Asm_Input ("rZ", val), system.address'Asm_Input ("r", addr)),
             volatile => True);
    end;

    function io_read_32(addr : system.Address) return kernel.u32 is
        use System.Machine_Code;
        value : kernel.u32;
    begin
        asm (template => "ldr %w0, [%1]", 
             inputs => (system.address'Asm_Input ("r", addr)),
             outputs => (kernel.u32'Asm_Output ("=r", value)),
             volatile => True);

        return value;
    end;

    procedure set_pinmux is
        use System.Storage_Elements;
        addr_offset : Storage_Offset := 16#6C#;
        base_addr   : system.Address := kernel.ioremap (controllers.pinmux_base_addr + addr_offset, 4);
    begin
        io_write_32 (0, base_addr);
    end;

    procedure set_gpio (pin : controllers.pin; s : state) is
        use kernel;
        use System.Storage_Elements;
        use controllers;
        base_addr   : system.Address;
        data : controllers.gpio_control := (bits => (others => 0), locks => (others => 0));
    begin
        set_pinmux;

        data.bits(pin.reg_bit) := (if s = high then 1 else 0);

        base_addr   := kernel.ioremap (get_register_phys_address (pin.port, GPIO_CNF), 4);
        io_write_32 (to_u32(data), base_addr);

        base_addr   := kernel.ioremap (get_register_phys_address (pin.port, GPIO_OE), 4);
        io_write_32 (to_u32(data), base_addr);

        base_addr   := kernel.ioremap (get_register_phys_address (pin.port, GPIO_OUT), 4);
        io_write_32 (to_u32(data), base_addr);
    end;

    procedure init (l : led_type) is
    begin
        set_gpio (controllers.header_pins(13), low);
    end init;

    procedure light (l : led_type; s : state) is
    begin
        kernel.print (s'image);
        set_gpio (controllers.header_pins(13), s);
    end light;

    function get_state (l : led_type) return state is
        use controllers;
        use kernel;
        base_addr : system.Address := kernel.ioremap (get_register_phys_address (controllers.header_pins(13).port, GPIO_OUT), 4);
        value : kernel.u32 := io_read_32 (base_addr);
        data : controllers.gpio_control;
        for data'address use value'address;
    begin
        return (if data.bits(controllers.header_pins(13).reg_bit) = 1 then high else low);
    end get_state;

    procedure deinit (l : led_type) is
    begin
        set_gpio (controllers.header_pins(13), low);
    end deinit;

end led.device;