with kernel;
with System;
with led.device;
with Ada.Unchecked_Conversion;

with Interfaces; use Interfaces;

with System.Machine_Code;
with System.Storage_Elements;
package body led.device is

    type Bit is mod 2 ** 1;

    procedure print_hex (value : kernel.u32) with
        Import        => True,
        Convention    => c,
        External_Name => "print_hex";

    procedure print_hex (value : system.Address) with
        Import        => True,
        Convention    => c,
        External_Name => "print_access_hex";

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

    procedure set_gpio (s : state) is
        type control is record
            bit_0  : bit;
            bit_1  : bit;
            bit_2  : bit;
            bit_3  : bit;
            bit_4  : bit;
            bit_5  : bit;
            bit_6  : bit;
            bit_7  : bit;
            lock_0 : bit;
            lock_1 : bit;
            lock_2 : bit;
            lock_3 : bit;
            lock_4 : bit;
            lock_5 : bit;
            lock_6 : bit;
            lock_7 : bit;
        end record;
        for control'size use 32;
    
        for control use record
            bit_0  at 0 range 0 .. 0;
            bit_1  at 0 range 1 .. 1;
            bit_2  at 0 range 2 .. 2;
            bit_3  at 0 range 3 .. 3;
            bit_4  at 0 range 4 .. 4;
            bit_5  at 0 range 5 .. 5;
            bit_6  at 0 range 6 .. 6;
            bit_7  at 0 range 7 .. 7;
            lock_0 at 1 range 0 .. 0;
            lock_1 at 1 range 1 .. 1;
            lock_2 at 1 range 2 .. 2;
            lock_3 at 1 range 3 .. 3;
            lock_4 at 1 range 4 .. 4;
            lock_5 at 1 range 5 .. 5;
            lock_6 at 1 range 6 .. 6;
            lock_7 at 1 range 7 .. 7;
        end record;
        type control_access is access all control;

        function to_u32 is new Ada.Unchecked_Conversion (Source => control, Target => kernel.u32);

        use kernel;
        use System.Storage_Elements;
        phys_addr : system.Address;
        addr_offset : Storage_Offset;
        pgprot        : kernel.u64 := 16#00e8000000000707#;
        base_addr   : system.Address;
        value : kernel.u32 := 16#40#;
        data : control := (others => 0);
    begin

        -- pinmux
        phys_addr := System'To_Address (16#70003000#);
        addr_offset := 16#6C#;
        base_addr   := kernel.ioremap (phys_addr + addr_offset, 4, pgprot);
        io_write_32 (0, base_addr);
  
        -- gpios
        phys_addr :=  System'To_Address (16#6000d000#);
        addr_offset := 16#04#;

        data.lock_6 := 0;
        data.bit_6  := (if s = high then 1 else 0);

        base_addr   := kernel.ioremap (phys_addr + addr_offset, 4, pgprot);
        io_write_32 (to_u32(data), base_addr);

        addr_offset := 16#14#;
        base_addr   := kernel.ioremap (phys_addr + addr_offset, 4, pgprot);
        io_write_32 (to_u32(data), base_addr);

        addr_offset := 16#24#;
        base_addr   := kernel.ioremap (phys_addr + addr_offset, 4, pgprot);
        io_write_32 (to_u32(data), base_addr);

    end;

    procedure init (l : led_type) is
    begin
        set_gpio (high);
    end init;

    procedure light (l : led_type; s : state) is
    begin
        null;
    end light;

    function get_state (l : led_type) return state is
    begin
        return high;
    end get_state;

    procedure deinit (l : led_type) is
    begin
        set_gpio (low);
    end deinit;

end led.device;



-- procedure init (l : led_type) is
--         use kernel;
--         phys_addr : kernel.u32 := 16#6000_d000#;
--         addr_offset : kernel.u32 := 16#4#;

--         --size        : kernel.u32 := 16#0ff#;
--         prot        : kernel.u32 := 16#713#;

--         --base_addr : kernel.u32_access := kernel.ioremap(phys_addr+addr_offset, 4, prot);
--         base_addr : kernel.u32_access;

--         --data        : array (1 .. 256) of aliased kernel.byte;
--         data        : control := ();
--         --data        : kernel.u32;
--         --data_access : kernel.byte_access := data (1)'Unchecked_Access;
--         dst_access  : kernel.u32_access  := to_u32_access (data);
--         --dst_access  : kernel.u32_access  := data'access;

--         --X : Int64 with Address => Other_Var'Address;
--         -- data : aliased kernel.u32 := 1;
--     begin
--         -- for i in 1 .. 256 loop
--         --     off := kernel.u32(i);
--         --     base_addr := kernel.ioremap(phys_addr+addr_offset+off, 4, prot);
--         --     --kernel.print(base_addr.all'image);
--         --     kernel.memcpy_fromio (dst => data'Unchecked_Access, src => base_addr, size => 1);
--         --     print_hex (data);
--         --     --kernel.print(data'image);
--         -- end loop;

--         base_addr := kernel.ioremap (phys_addr + addr_offset, 4, prot);
--         --kernel.print(base_addr.all'image);
--         kernel.memcpy_fromio (dst => dst_access, src => base_addr, size => 4);

--         print_hex (data);
--         --kernel.print(data'image);

--         --for i of data loop
--         --    print_hex (kernel.u32 (i));
--         --end loop;
--     end init;

    --procedure c_iowrite32 (addr : system.Address; val : kernel.u32) with
    --    Import        => True,
    --    Convention    => c,
    --    External_Name => "my_iowrite32";
--
    --procedure do_mux with
    --    Import        => True,
    --    Convention    => c,
    --    External_Name => "do_mux";
--
    --procedure do_gpio with
    --    Import        => True,
    --    Convention    => c,
    --    External_Name => "do_gpio";

    --
--    procedure set_pinmux is
--        type two_bits is mod 2 ** 1;
--        type control is record
--            pm         : two_bits;
--            pupd       : two_bits;
--            tristate   : bit;
--            park       : bit;
--            e_input    : bit;
--            lock       : bit;
--            e_hsm      : bit;
--            e_schmt    : bit;
--            drive_type : two_bits;
--        end record;
--        for control'size use 32;
--        
--        for control use record
--            pm         at 0 range 0 .. 1;
--            pupd       at 0 range 2 .. 3;
--            tristate   at 0 range 4 .. 4;
--            park       at 0 range 5 .. 5;
--            e_input    at 0 range 6 .. 6;
--            lock       at 0 range 7 .. 7;
--            e_hsm      at 0 range 9 .. 9;
--            e_schmt    at 0 range 12 .. 12;
--            drive_type at 0 range 13 .. 14;
--        end record;
--        type control_access is access all control;
--
--        function to_u32_access is new Ada.Unchecked_Conversion (Source => control_access, Target => kernel.u32_access);
--
--        use kernel;
--        phys_addr   : kernel.u32 := 16#70003000#;
--        addr_offset : kernel.u32 := 16#6C#;
--        prot        : kernel.u32 := 16#713#;
--        --prot        : kernel.u32 := 16#00#;
--
--        data : aliased control;
--        data_access : kernel.u32_access := to_u32_access(data'Unchecked_Access);
--        base_addr   : aliased kernel.u32_access;
--        data2 : kernel.u32 := 0;
--    begin
--        base_addr   := kernel.ioremap (phys_addr + addr_offset, 4, prot);
--        --kernel.memcpy_fromio (dst => data_access, src => base_addr, size => 4);
--        data.tristate := 0;
--        --my_iowrite32 (base_addr, data2);
--    end;