with led; use led;
with led.device; use led.device;

with System.Machine_Code;
with Ada.Unchecked_Conversion;

package body flash_led is

    half_period_ms : kernel.u32 := 500;

    wq : kernel.workqueue_struct_access := kernel.workqueue_struct_access (system.null_address);
    work : kernel.work_struct;
    timer : kernel.timer_list;
    delayed_work : aliased kernel.delayed_work;

    my_led : led_type := (pin_nbr => 14, label => "my_led");

    procedure work_callback (work : kernel.work_struct_access) with convention => c;
    procedure work_callback (work : kernel.work_struct_access) is
        led_state : state := get_state (my_led);
    begin
        light (my_led, not led_state);
        kernel.queue_delayed_work(wq, delayed_work'access, kernel.msecs_to_jiffies (half_period_ms));
    end;

    procedure setup_delayed_work is
        function to_unsigned_long is new Ada.Unchecked_Conversion (Source => delayed_work_access, Target => ic.unsigned_long);
    begin
        work.func := work_callback'access;
        work.entryy.prev := delayed_work.work.entryy'access;
        work.entryy.next := delayed_work.work.entryy'access;
        delayed_work.work := work;

        timer.func := delayed_work_timer_fn'access;
        timer.expires := 0;
        timer.data := to_unsigned_long(delayed_work'access);
        delayed_work.timer := timer;

        if wq = kernel.null_wq then
            wq := kernel.alloc_workqueue ("flash_led_work");
        end if;

        if wq /= kernel.null_wq then
            kernel.queue_delayed_work(wq, delayed_work'access, kernel.msecs_to_jiffies (half_period_ms));
        end if;

    end;

    procedure cleanup_delayed_work is
    begin
        if wq /= kernel.null_wq then
            cancel_delayed_work (delayed_work'access);
		    flush_workqueue (wq);
		    destroy_workqueue (wq);
        end if;
    end;

    procedure ada_init_module is
        procedure ada_linux_init with
            import        => true,
            convention    => ada,
            external_name => "flash_ledinit"; 
    begin
        ada_linux_init;
        init (my_led);
        setup_delayed_work;
    end;

    procedure ada_cleanup_module is
    begin
        cleanup_delayed_work;
        deinit(my_led);
    end;
end flash_led;
