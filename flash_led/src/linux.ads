with interfaces.c;
with system;

package linux is

    package ic renames interfaces.c;

    -- debug
    procedure printk (s : string);

    -- gpio
    function gpio_request (gpio : ic.unsigned; label : ic.char_array) return ic.int with
        import        => true,
        convention    => c,
        external_name => "gpio_request";

    function gpio_direction_output (gpio : ic.unsigned; value : ic.int) return ic.int;
    function gpio_get_value (gpio : ic.unsigned) return ic.int;
    procedure gpio_set_value (gpio : ic.unsigned; value : ic.int);
    
    procedure gpio_free (gpio : ic.unsigned) with
        import        => true,
        convention    => c,
        external_name => "gpio_free";

    -- timer
    jiffies : ic.unsigned_long with
        import        => true,
        convention    => c,
        external_name => "jiffies";

    function msecs_to_jiffies
       (m : ic.unsigned) return ic.unsigned_long with
        import        => true,
        convention    => c,
        external_name => "__msecs_to_jiffies";

    type hlist_node;
    type hlist_node_acc is access hlist_node;

    type hlist_node is record
        next  : hlist_node_acc;
        pprev : hlist_node_acc;
    end record with
        convention => c;

    type timer_list_function_t is access procedure (data : ic.unsigned_long) with
        convention => c;

    type timer_list is record
        c_entry    : hlist_node;
        expires    : ic.unsigned_long;
        c_function : timer_list_function_t;
        data       : ic.unsigned_long;
        flags      : ic.int;
    end record with
        convention => c;

    procedure init_timer_key
       (timer : access timer_list; flags : ic.unsigned;
        name  : ic.char_array; key : system.address) with
        import        => true,
        convention    => c,
        external_name => "init_timer_key";

    procedure add_timer (timer : access timer_list) with
        import        => true,
        convention    => c,
        external_name => "add_timer";

    function del_timer (timer : access timer_list) return ic.int with
        import        => true,
        convention    => c,
        external_name => "del_timer";

end linux;
