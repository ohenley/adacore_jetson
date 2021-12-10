with kernel;

package body led.device is -- using linux interface

    procedure init (l : led_type) is
        res : kernel.result;
    begin
        res := kernel.gpio_request (kernel.u32(l.pin_nbr), l.label);
    end;

    procedure light (l : led_type; s : state) is
        res : kernel.result;
    begin
        kernel.print(l.pin_nbr'image);
        res := kernel.gpio_direction_output (kernel.u32(l.pin_nbr), s);
    end;

    function get_state (l : led_type) return state is
    begin
        return kernel.gpio_get_value (kernel.u32(l.pin_nbr));
    end;

    procedure deinit (l : led_type) is
    begin
        kernel.gpio_free (kernel.u32(l.pin_nbr));
    end;

end led.device;
