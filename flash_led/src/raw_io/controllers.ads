with system;
with kernel;
with Ada.Unchecked_Conversion;
with System.Storage_Elements; use System.Storage_Elements;

package Controllers is

    type function_type is
       (GPIO, VDC3_3, VDC5_0, GND, I2C0_SDA, I2C0_CLK, I2C1_SDA, I2C1_SCL,
        UART1_TXD, UART1_RXD, AUD_CLK, UART1_RTS, SPI1_SCK, SPI0_MOSI,
        SPI0_MISO, SPI0_SCK, SPI0_CS0, CAM_MCLK, PWM, I2S0_FS, SPI1_MOSI, I2S0_SCLK,
        SPI1_CS1, SPI1_CS0, SPI1_MISO, SPI0_CS1, UART1_CTS, I2S0_DIN,
        I2S_DOUT, NIL);

    type gpio_tegra_port is
       (PA, PB, PC, PD, PE, PF, PG, PH, PI, PJ, PK, PL, PM, PN, PO, PP, PQ, PR,
        PS, PT, PU, PV, PW, PX, PY, PZ, PAA, PBB, PCC, PDD, PEE, NIL);

    type gpio_bank_desc is range 1 .. 8;

    type ports_banks_map is array (gpio_tegra_port) of gpio_bank_desc;
    ports_banks : constant ports_banks_map :=
       (1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 6, 6, 6, 6,
        7, 7, 7, 7, 8, 8, 8, 8);

    type banks_array is array (gpio_bank_desc) of system.address;

    gpio_banks : constant banks_array :=
       (System'To_Address (16#6000_d000#), 
        System'To_Address (16#6000_d100#),
        System'To_Address (16#6000_d200#), 
        System'To_Address (16#6000_d300#),
        System'To_Address (16#6000_d400#), 
        System'To_Address (16#6000_d500#),
        System'To_Address (16#6000_d600#), 
        System'To_Address (16#6000_d700#));

    type header_pin is range 1 .. 40; -- jetson nano physical expansion pinout
    type gpio_linux_nbr is range 0 .. 255; -- sudo cat /sys/kernel/debug/gpio
    type register_bit is range 0 .. 7;

    type pin (default : function_type := GPIO; alternate: function_type := GPIO) is record
        case default is
            when VDC3_3 .. GND =>
                null;
            when others =>
                linux_nbr     : gpio_linux_nbr;
                port          : gpio_tegra_port;
                reg_bit       : register_bit;
        end case;
    end record;

    type header_pins_array is array (header_pin) of pin;

    header_pins : constant header_pins_array :=
       (1   => (default => VDC3_3,    alternate => NIL), 
        2   => (default => VDC5_0,    alternate => NIL), 
        3   => (default => I2C1_SDA,  alternate => GPIO,      linux_nbr => 75,  port => PJ,  reg_bit => 3),
        4   => (default => VDC5_0,    alternate => NIL), 
        5   => (default => I2C1_SCL,  alternate => GPIO,      linux_nbr => 74,  port => PJ,  reg_bit => 2), 
        6   => (default => GND,       alternate => NIL),
        7   => (default => GPIO,      alternate => AUD_CLK,   linux_nbr => 216, port => PBB, reg_bit => 0), 
        8   => (default => UART1_TXD, alternate => GPIO,      linux_nbr => 48,  port => PG,  reg_bit => 0), 
        9   => (default => GND,       alternate => NIL),
       10   => (default => UART1_RXD, alternate => GPIO,      linux_nbr => 49,  port => PG,  reg_bit => 1), 
       11   => (default => GPIO,      alternate => UART1_RTS, linux_nbr => 50,  port => PG,  reg_bit => 2),
       12   => (default => GPIO,      alternate => I2S0_SCLK, linux_nbr => 79,  port => PJ,  reg_bit => 7), 
       13   => (default => GPIO,      alternate => SPI1_SCK,  linux_nbr => 14,  port => PB,  reg_bit => 6), 
       14   => (default => GND,       alternate => NIL), 
       15   => (default => GPIO,      alternate => NIL,       linux_nbr => 194, port => PY,  reg_bit => 2), 
       16   => (default => GPIO,      alternate => SPI1_CS1,  linux_nbr => 232, port => PDD, reg_bit => 0), 
       17   => (default => VDC3_3,    alternate => NIL),
       18   => (default => GPIO,      alternate => SPI1_CS0,  linux_nbr => 15,  port => PB,  reg_bit => 7), 
       19   => (default => GPIO,      alternate => SPI0_MOSI, linux_nbr => 16,  port => PC,  reg_bit => 0), 
       20   => (default => GND,       alternate => NIL), 
       21   => (default => GPIO,      alternate => SPI0_MISO, linux_nbr => 17,  port => PC,  reg_bit => 1), 
       22   => (default => GPIO,      alternate => SPI1_MISO, linux_nbr => 13,  port => PB,  reg_bit => 5),
       23   => (default => GPIO,      alternate => SPI0_SCK,  linux_nbr => 18,  port => PC,  reg_bit => 2), 
       24   => (default => GPIO,      alternate => SPI0_CS0,  linux_nbr => 19,  port => PC,  reg_bit => 3), 
       25   => (default => GND,       alternate => NIL),  
       26   => (default => GPIO,      alternate => SPI0_CS1,  linux_nbr => 20,  port => PC,  reg_bit => 4), 
       27   => (default => I2C0_SDA,  alternate => GPIO,      linux_nbr => 13,  port => PB,  reg_bit => 5),
       28   => (default => I2C0_CLK,  alternate => GPIO,      linux_nbr => 18,  port => PC,  reg_bit => 2), 
       29   => (default => GPIO,      alternate => CAM_MCLK,  linux_nbr => 149, port => PS,  reg_bit => 5), 
       30   => (default => GND,       alternate => NIL), 
       31   => (default => GPIO,      alternate => CAM_MCLK,  linux_nbr => 200, port => PZ,  reg_bit => 0), 
       32   => (default => GPIO,      alternate => PWM,       linux_nbr => 168, port => PV,  reg_bit => 0),
       33   => (default => GPIO,      alternate => PWM,       linux_nbr => 38,  port => PE,  reg_bit => 6), 
       34   => (default => GND,       alternate => NIL),  
       35   => (default => GPIO,      alternate => I2S0_FS,   linux_nbr => 76,  port => PJ,  reg_bit => 4),
       36   => (default => GPIO,      alternate => UART1_CTS, linux_nbr => 51,  port => PG,  reg_bit => 3), 
       37   => (default => GPIO,      alternate => SPI1_MOSI, linux_nbr => 12,  port => PB,  reg_bit => 4),
       38   => (default => GPIO,      alternate => I2S0_DIN,  linux_nbr => 77,  port => PJ,  reg_bit => 5), 
       39   => (default => GND,       alternate => NIL),   
       40   => (default => GPIO,      alternate => I2S_DOUT,  linux_nbr => 78,  port => PJ,  reg_bit => 6));

    type bit is mod 2**1; 
    type two_bits is mod 2**2;

    type pinmux_control is record
        pm         : two_bits;
        pupd       : two_bits;
        tristate   : bit;
        park       : bit;
        e_input    : bit;
        lock       : bit;
        e_hsm      : bit;
        e_schmt    : bit;
        drive_type : two_bits;
    end record;
    for pinmux_control'Size use 32;

    for pinmux_control use record
        pm         at 0 range  0 ..  1;
        pupd       at 0 range  2 ..  3;
        tristate   at 0 range  4 ..  4;
        park       at 0 range  5 ..  5;
        e_input    at 0 range  6 ..  6;
        lock       at 0 range  7 ..  7;
        e_hsm      at 0 range  9 ..  9;
        e_schmt    at 0 range 12 .. 12;
        drive_type at 0 range 13 .. 14;
    end record;

    pinmux_base_addr : system.Address := System'To_Address (16#7000_3000#);

    type gpio_bit_array is array (register_bit) of bit with Pack;

    type gpio_control is record
        bits : gpio_bit_array;
        locks : gpio_bit_array;
    end record;
    for gpio_control'size use 32;

    for gpio_control use record
        bits  at 0 range 0 .. 7; 
        locks at 1 range 0 .. 7;
    end record;

    type register is (GPIO_CNF, GPIO_OE, GPIO_OUT, GPIO_IN, GPIO_INT_STA, GPIO_INT_ENB, GPIO_INT_LVL, GPIO_INT_CLR);
    type registers_offsets_array is array (register) of Storage_Offset;

    registers_offsets : constant registers_offsets_array :=
    (GPIO_CNF       => 16#00#,
     GPIO_OE        => 16#10#,
     GPIO_OUT       => 16#20#,
     GPIO_IN        => 16#30#,
     GPIO_INT_STA   => 16#40#,
     GPIO_INT_ENB   => 16#50#,
     GPIO_INT_LVL   => 16#60#,
     GPIO_INT_CLR   => 16#70#);

    function to_u32 is new Ada.Unchecked_Conversion (Source => gpio_control, Target => kernel.u32);

    function get_bank_phys_address (port : gpio_tegra_port) return system.address is
        (gpio_banks(ports_banks(port)));

    function get_register_phys_address (port : gpio_tegra_port; reg : register) return system.address is
        (get_bank_phys_address (port) + registers_offsets (reg) + (gpio_tegra_port'pos(port) mod 4) * 4);


end Controllers;
