with system;
with Interfaces.C; use Interfaces.C;
with linux;
-- with gpio_h;
with Timer_H;
with Jiffies_H;
with Printk_H;

with ada.unchecked_conversion;

package body ada_linux is

    package IC renames Interfaces.C;

    --procedure Last_Chance_Handler (Msg : System.Address; Line : Integer) is
    --begin
    --    null;
    --end;

    --procedure Call_Last_Chance_Handler_With_Message (Message : String) is
    --begin
    --    null;
    --end;
    --function to_char_array is new Ada.Unchecked_Conversion (Source => string, Target => ic.char_array);

    function "+" (s : String) return ic.char_array is
    begin
        return to_c (s);
    end "+";

    procedure ada_linuxinit;
    pragma Import (C, ada_linuxinit, "ada_linuxinit");


    led_timer : aliased Timer_H.Timer_List;
    counter : natural := 0;

    procedure timer_callback (data : Interfaces.C.Unsigned_Long) with Convention => C;
    procedure timer_callback (data : Interfaces.C.Unsigned_Long) is
        res        : IC.int;
        --from_timer : String := "from_timer";
        str : ic.char_array := "toto" & ic.nul;
    begin
        res := linux.printk_int (str, 1);
        --counter := counter + 1;
    end timer_callback;

    --type timer_acc is access all Timer_H.Timer_List;
    --led_timer_acc : timer_acc := led_timer'Access;

    procedure setup_timer is
        --timer_cb_acc : timer_h.Timer_List_Function_T := timer_callback'Access;
        str : ic.char_array := "yo" & ic.nul;
        --name   : String        := "yo";
    begin
        timer_h.Init_Timer_Key (led_timer'Access, 0, str, System.Null_Address);
        led_timer.C_Function := timer_callback'Access;
        led_timer.data       := 0;
    end setup_timer;

    procedure ada_init_module is
    begin
        ada_linuxinit;
        declare
            msec_in_jiffies : ic.unsigned_long := jiffies_h.Msecs_To_Jiffies (1000);
            jifs : ic.unsigned_long := jiffies_h.jiffies;
            res  : IC.int;
        begin
            setup_timer;
            res := timer_h.mod_timer (led_timer'Access, jifs + msec_in_jiffies);
            res := linux.printk_int (+res'image, 1);
        end;
    end ada_init_module;

    procedure ada_cleanup_module is
        --msg_bye : String := "bye!!!";
        res     : IC.int;
    begin
        --res := linux.printk_int (+msg_bye, 1);
        res := linux.printk_int (+(counter'image), 1);
        res := timer_h.del_timer (led_timer'Access);
    end ada_cleanup_module;

end ada_linux;
