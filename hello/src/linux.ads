pragma Restrictions (No_Secondary_Stack);
with Interfaces.C;

package linux is

    package IC renames Interfaces.C;

    function printk_int
       (format : IC.char_array; value : IC.int) return IC.int with
        Import,
        Convention    => C_Variadic_1,
        External_Name => "printk";

end linux;
