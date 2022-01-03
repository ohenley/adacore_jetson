package led.device is

    function "not" (s : state) return state is
        (if s = high then low else high);

    type led_type;

    procedure init (l : led_type);
    procedure light (l : led_type; s : state);
    function get_state (l : led_type) return state;
    procedure deinit (l : led_type);

    type led_type is record
        pin_nbr : natural := 14;
        label : string (1 .. 6) := "my_led";
    end record;

    a_led : led_type;

end led.device;