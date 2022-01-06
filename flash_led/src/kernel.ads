with interfaces.c;
with system;

with led;

package kernel is

    type u32 is mod 2**32;
    for u32'Size use 32;

    type u64 is mod 2**64;
    for u64'Size use 64;

    package ic renames interfaces.c;

    type s32 is new ic.int;

    type result is (success, error);

    -- debug
    procedure print (s : string);

    procedure print_hex (value : kernel.u32) with
        Import        => True,
        Convention    => c,
        External_Name => "print_hex";

    procedure print_hex (value : system.Address) with
        Import        => True,
        Convention    => c,
        External_Name => "print_access_hex";

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

    type timer_list_function_t is access procedure (data : ic.unsigned_long) with
        convention => c;

    type timer_list is record
        entryy     : hlist_node;
        expires    : ic.unsigned_long;
        func       : timer_list_function_t;
        data       : ic.unsigned_long;
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

    -- io
    type byte is mod 2**8;
    type byte_access is access all byte;

    function ioremap (phys_addr : system.Address; size : u32) return system.address;

---------------
    type list_head;
    type list_head_access is access all list_head;

    type list_head is record
        prev : list_head_access;
        next : list_head_access;
    end record with
        convention => c;
 
    type work_struct;
    type work_struct_access is access all work_struct;

    type work_func_t is access procedure (work : work_struct_access) with
        convention => c;

    type atomic_long_t is new ic.unsigned_long;
    type work_struct is record
        data : atomic_long_t;
        entryy : aliased list_head;
        func : work_func_t;
    end record with
        convention => c;

    type workqueue_struct_access is new system.address;
    null_wq : kernel.workqueue_struct_access := kernel.workqueue_struct_access (system.null_address);

    type delayed_work is record
        work : work_struct;
        timer : timer_list;
        wq : workqueue_struct_access;
        cpu : ic.int;
    end record;
    type delayed_work_access is access all delayed_work;

    procedure queue_delayed_work (wq : workqueue_struct_access;
                                  work : delayed_work_access;
                                  delayy : u64);
    
    procedure delayed_work_timer_fn (data : ic.unsigned_long) with
        import        => true,
        convention    => c,
        external_name => "delayed_work_timer_fn";

    function alloc_workqueue (name : string) return workqueue_struct_access;

    procedure cancel_delayed_work (delayed_work : delayed_work_access) with
        import        => true,
        convention    => c,
        external_name => "cancel_delayed_work";

	procedure flush_workqueue (wq : workqueue_struct_access) with 
        import        => true,
        convention    => c,
        external_name => "flush_workqueue";

	procedure destroy_workqueue (wq : workqueue_struct_access) with
        import        => true,
        convention    => c,
        external_name => "destroy_workqueue";

end kernel;
