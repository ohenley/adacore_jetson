
pragma Suppress (All_Checks);

with system;
with Interfaces.C; use Interfaces.C;
--with Interfaces.C.Strings;
with linux;
with gpio_h;
with printk_h;

with ada.unchecked_conversion;

package body ada_linux is

    procedure Last_Chance_Handler (Msg : System.Address; Line : Integer) is
    begin
        null;
    end;

    procedure Call_Last_Chance_Handler_With_Message (Message : String) is
    begin
        null;
    end;

    procedure ada_linuxinit;
    pragma Import (C, ada_linuxinit, "ada_linuxinit");

    package IC renames Interfaces.C;
    type chars_ptr is access Interfaces.C.char_array;

    procedure ada_init_module is
    begin
        ada_linuxinit;
        declare
            res : IC.int;
            hello : string := "kiri";
            msg_hello : IC.char_array := to_c(hello);
        begin
            -- res := printk_h.Vprintk (msg_hello, 1);
            res := linux.printk_int (msg_hello, 1);
        end;
    end;

    procedure ada_cleanup_module is
        msg_bye : IC.char_array := "bye!!! ";
        res : IC.int;
    begin
        msg_bye(msg_bye'last) := ic.nul;
        res := linux.printk_int (msg_bye, 1);
    end;

end ada_linux;


    --     for i in 1..5 loop
    --     x := x + 1;
    -- end loop;
    -- if x < 0 then
    --     toto;
    -- end if;

    -- procedure toto is
    --     hello : string := "hello";
    --     msg_hello : IC.char_array := to_c(hello);
    -- begin
    --     null;
    -- end;


    -- procedure Last_Chance_Handler (Msg : System.Address; Line : Integer) is
    -- begin
    --     null;
    -- end Last_Chance_Handler;




    -- procedure ada_init_module is
    --     res : IC.int;
    --     gpio_num : IC.unsigned := 16;
    --     msg_zero : IC.char_array := "zero!!! ";
    --     msg_puck : IC.char_array := "puck!!! ";
    --     gpio_name : IC.char_array := "gpio16";
    -- begin
    --     res := gpio_h.gpio_request(gpio_num, gpio_name);
    --     if res = 0 then
    --         res := linux.printk_int (msg_zero, 1);
    --     else
    --         res := linux.printk_int (msg_puck, 1);
    --     end if;
    --     
    -- end;

--    procedure ada_init_module is
--    use IC;
--        msg_gpio : IC.char_array := "gpio!!! ";
--        msg_hello : IC.char_array := "hello!!! ";
--        gpio_name : IC.char_array := "gpio-17";
--        gpio_num : IC.unsigned := 17;
--        irq_number : IC.int;
--        res : IC.int;
--    begin
--        res := gpio_h.gpio_request(gpio_num, gpio_name);
--        res := gpio_h.Gpio_Direction_Input (gpio_num);
--        irq_number := gpio_h.Gpio_To_Irq (gpio_num);
--
--        declare
--            irq_num_str : string := irq_number'image;
--            irq_num_str_len : ic.size_t := irq_num_str'Length;
--            irq_num : ic.char_array(1..irq_num_str_len);
--        begin
--            to_c(irq_num_str, irq_num, irq_num_str_len);
--            res := linux.printk_int (irq_num, 1);
--        end;
--
--        
--
--        if res = 0 then
--            msg_gpio(msg_gpio'last) := ic.nul;
--            res := linux.printk_int (msg_gpio, 1);
--        end if;
--
--        msg_gpio(msg_hello'last) := ic.nul;
--        res := linux.printk_int (msg_hello, 1);
--    end;