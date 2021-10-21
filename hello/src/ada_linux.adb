pragma Restrictions (No_Secondary_Stack);

with Interfaces.C;
with linux;

package body ada_linux is

    package IC renames Interfaces.C;

    procedure ada_init_module is
        msg_hello : IC.char_array := "hello!!! ";
        res : IC.int;
    begin
        msg_hello(msg_hello'last) := ic.nul;
        res := linux.printk_int (msg_hello, 1);
    end;

    procedure ada_cleanup_module is
        msg_bye : IC.char_array := "bye!!! ";
        res : IC.int;
    begin
        msg_bye(msg_bye'last) := ic.nul;
        res := linux.printk_int (msg_bye, 1);
    end;

end ada_linux;