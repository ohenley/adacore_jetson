with interfaces.c;
with system;

package kernel is

    type u32 is mod 2**32;
    for u32'Size use 32;

    type u64 is mod 2**64;
    for u64'Size use 64;

    type s32 is new interfaces.c.int;

    type result is (success, error);

    package led is 
        type state is (low, high);
        for state use (low => 0, high => 1);
        for state'size use s32'size;
    end led;

    -- debug
    procedure print (s : string);

    -- gpio
    function gpio_request (gpio : u32; label : string) return result;
    function gpio_direction_output (gpio : u32; state : led.state) return result;
    function gpio_get_value (gpio : u32) return led.state;
    procedure gpio_free (gpio : u32) with
        import        => true,
        convention    => c,
        external_name => "gpio_free";

    -- timer
    jiffies : u64 with
        import        => true,
        convention    => c,
        external_name => "jiffies";

    function msecs_to_jiffies (m : u32) return u64 with
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

    type timer_list_function_t is access procedure (data : u32) with
        convention => c;

    type timer_list is record
        c_entry    : hlist_node;
        expires    : u64;
        c_function : timer_list_function_t;
        data       : u32;
        flags      : s32;
    end record with
        convention => c;

    procedure init_timer_key (timer : access timer_list; 
                              flags : u32;
                              name  : string; 
                              key   : system.address);

    procedure add_timer (timer : access timer_list) with
        import        => true,
        convention    => c,
        external_name => "add_timer";

    function del_timer (timer : access timer_list) return result;

end kernel;
