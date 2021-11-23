with Interfaces.C;
with system;

package linux is

    package IC renames Interfaces.C;

    -- debug
    procedure Printk (s : String);

    -- gpio
    function Gpio_Request
       (Gpio : ic.Unsigned; Label : ic.char_array)
        return ic.Int with
        Import        => True,
        Convention    => C,
        External_Name => "gpio_request";

    function Gpio_Direction_Output (Gpio : IC.Unsigned; Value : ic.Int) return ic.Int;
    function Gpio_Get_Value (Gpio : ic.Unsigned) return ic.Int;
    procedure Gpio_Set_Value (Gpio : ic.Unsigned; Value : ic.Int);
    procedure Gpio_Free (Gpio : ic.Unsigned) with
        Import        => True,
        Convention    => C,
        External_Name => "gpio_free";

    -- timer
    jiffies : ic.Unsigned_Long with
        Import        => True,
        Convention    => C,
        External_Name => "jiffies";

    function Msecs_To_Jiffies
       (M : ic.Unsigned) return ic.Unsigned_Long with
        Import        => True,
        Convention    => C,
        External_Name => "__msecs_to_jiffies";

    type hlist_node;
    type hlist_node_acc is access hlist_node;

    type hlist_node is record
        next  : hlist_node_acc;
        pprev : hlist_node_acc;
    end record with
        Convention => C;

    type Timer_List_Function_T is access procedure
       (data : ic.Unsigned_Long) with
        Convention => C;

    type Timer_List is record
        C_Entry    : hlist_node;
        Expires    : ic.Unsigned_Long;
        C_Function : Timer_List_Function_T;
        Data       : ic.Unsigned_Long;
        Flags      : ic.Int;
    end record with
        Convention => C;

    procedure Init_Timer_Key
       (Timer : access Timer_List; Flags : ic.Unsigned;
        Name  : ic.char_array; Key : System.Address) with
        Import        => True,
        Convention    => C,
        External_Name => "init_timer_key";

    procedure Add_Timer (Timer : access Timer_List) with
        Import        => True,
        Convention    => C,
        External_Name => "add_timer";

    function Del_Timer (Timer : access Timer_List) return ic.Int with
        Import        => True,
        Convention    => C,
        External_Name => "del_timer";

end linux;
