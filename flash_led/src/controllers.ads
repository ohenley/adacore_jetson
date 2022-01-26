With System;
With Kernel;
With Ada.Unchecked_Conversion;
With System.Storage_Elements; Use System.Storage_Elements;

Package Controllers Is

    Type Function_Type Is
       (GPIO, VDC3_3, VDC5_0, GND, NIL, I2C0_SDA, I2C0_CLK, I2C1_SDA, I2C1_SCL,
        UART1_TXD, UART1_RXD, AUD_CLK, UART1_RTS, SPI1_SCK, SPI0_MOSI,
        SPI0_MISO, SPI0_SCK, SPI0_CS0, CAM_MCLK, PWM, I2S0_FS, SPI1_MOSI, I2S0_SCLK,
        SPI1_CS1, SPI1_CS0, SPI1_MISO, SPI0_CS1, UART1_CTS, I2S0_DIN,
        I2S_DOUT);

    Type Gpio_Tegra_Port Is
       (PA, PB, PC, PD, PE, PF, PG, PH, PI, PJ, PK, PL, PM, PN, PO, PP, PQ, PR,
        PS, PT, PU, PV, PW, PX, PY, PZ, PAA, PBB, PCC, PDD, PEE, NIL);

    Type Gpio_Bank_Desc Is Range 1 .. 8;

    Type Banks_Array Is Array (Gpio_Bank_Desc) Of System.Address;

    Gpio_Banks : Constant Banks_Array :=
       (System'To_Address (16#6000_D000#), 
        System'To_Address (16#6000_D100#),
        System'To_Address (16#6000_D200#), 
        System'To_Address (16#6000_D300#),
        System'To_Address (16#6000_D400#), 
        System'To_Address (16#6000_D500#),
        System'To_Address (16#6000_D600#), 
        System'To_Address (16#6000_D700#));

    Type Jetson_Nano_Header_Pin Is Range 1 .. 40; -- Jetson Nano Physical Expansion Pinout
    Type Gpio_Linux_Nbr Is Range 0 .. 255;        -- sudo cat /sys/kernel/debug/gpio
    Type Register_Bit Is Range 0 .. 7;

    Type Pin (Default : Function_Type := GPIO) Is Record
        Alternate: Function_Type := GPIO;
        Case Default Is
            When VDC3_3 .. GND =>
                Null;
            When Others =>
                Linux_Nbr     : Gpio_Linux_Nbr;
                Port          : Gpio_Tegra_Port;
                Reg_Bit       : Register_Bit;
                Pinmux_Offset : Storage_Offset;
        End Case;
    End Record;

    Type Jetson_Nano_Header_Pins_Array Is Array (Jetson_Nano_Header_Pin) Of Pin;

    Jetson_Nano_Header_Pins : Constant Jetson_Nano_Header_Pins_Array :=
       (1   => (Default => VDC3_3,    Alternate => NIL), 
        2   => (Default => VDC5_0,    Alternate => NIL), 
        3   => (Default => I2C1_SDA,  Alternate => GPIO,      Linux_Nbr => 75,  Port => PJ,  Reg_Bit => 3, Pinmux_Offset => 16#C8#),
        4   => (Default => VDC5_0,    Alternate => NIL), 
        5   => (Default => I2C1_SCL,  Alternate => GPIO,      Linux_Nbr => 74,  Port => PJ,  Reg_Bit => 2, Pinmux_Offset => 16#C4#), 
        6   => (Default => GND,       Alternate => NIL),
        7   => (Default => GPIO,      Alternate => AUD_CLK,   Linux_Nbr => 216, Port => PBB, Reg_Bit => 0, Pinmux_Offset => 16#180#), 
        8   => (Default => UART1_TXD, Alternate => GPIO,      Linux_Nbr => 48,  Port => PG,  Reg_Bit => 0, Pinmux_Offset => 16#F4#), 
        9   => (Default => GND,       Alternate => NIL),
       10   => (Default => UART1_RXD, Alternate => GPIO,      Linux_Nbr => 49,  Port => PG,  Reg_Bit => 1, Pinmux_Offset => 16#F8#), 
       11   => (Default => GPIO,      Alternate => UART1_RTS, Linux_Nbr => 50,  Port => PG,  Reg_Bit => 2, Pinmux_Offset => 16#FC#),
       12   => (Default => GPIO,      Alternate => I2S0_SCLK, Linux_Nbr => 79,  Port => PJ,  Reg_Bit => 7, Pinmux_Offset => 16#150#), 
       13   => (Default => GPIO,      Alternate => SPI1_SCK,  Linux_Nbr => 14,  Port => PB,  Reg_Bit => 6, Pinmux_Offset => 16#6C#), 
       14   => (Default => GND,       Alternate => NIL), 
       15   => (Default => GPIO,      Alternate => NIL,       Linux_Nbr => 194, Port => PY,  Reg_Bit => 2, Pinmux_Offset => 16#1F8#), 
       16   => (Default => GPIO,      Alternate => SPI1_CS1,  Linux_Nbr => 232, Port => PDD, Reg_Bit => 0, Pinmux_Offset => 16#74#), 
       17   => (Default => VDC3_3,    Alternate => NIL),
       18   => (Default => GPIO,      Alternate => SPI1_CS0,  Linux_Nbr => 15,  Port => PB,  Reg_Bit => 7, Pinmux_Offset => 16#70#), 
       19   => (Default => GPIO,      Alternate => SPI0_MOSI, Linux_Nbr => 16,  Port => PC,  Reg_Bit => 0, Pinmux_Offset => 16#50#), 
       20   => (Default => GND,       Alternate => NIL), 
       21   => (Default => GPIO,      Alternate => SPI0_MISO, Linux_Nbr => 17,  Port => PC,  Reg_Bit => 1, Pinmux_Offset => 16#54#), 
       22   => (Default => GPIO,      Alternate => SPI1_MISO, Linux_Nbr => 13,  Port => PB,  Reg_Bit => 5, Pinmux_Offset => 16#68#),
       23   => (Default => GPIO,      Alternate => SPI0_SCK,  Linux_Nbr => 18,  Port => PC,  Reg_Bit => 2, Pinmux_Offset => 16#58#), 
       24   => (Default => GPIO,      Alternate => SPI0_CS0,  Linux_Nbr => 19,  Port => PC,  Reg_Bit => 3, Pinmux_Offset => 16#5C#), 
       25   => (Default => GND,       Alternate => NIL),  
       26   => (Default => GPIO,      Alternate => SPI0_CS1,  Linux_Nbr => 20,  Port => PC,  Reg_Bit => 4, Pinmux_Offset => 16#60#), 
       27   => (Default => I2C0_SDA,  Alternate => GPIO,      Linux_Nbr => 13,  Port => PB,  Reg_Bit => 5, Pinmux_Offset => 16#C0#),
       28   => (Default => I2C0_CLK,  Alternate => GPIO,      Linux_Nbr => 18,  Port => PC,  Reg_Bit => 2, Pinmux_Offset => 16#BC#), 
       29   => (Default => GPIO,      Alternate => CAM_MCLK,  Linux_Nbr => 149, Port => PS,  Reg_Bit => 5, Pinmux_Offset => 16#1E4#), 
       30   => (Default => GND,       Alternate => NIL), 
       31   => (Default => GPIO,      Alternate => CAM_MCLK,  Linux_Nbr => 200, Port => PZ,  Reg_Bit => 0, Pinmux_Offset => 16#27C#), 
       32   => (Default => GPIO,      Alternate => PWM,       Linux_Nbr => 168, Port => PV,  Reg_Bit => 0, Pinmux_Offset => 16#1FC#),
       33   => (Default => GPIO,      Alternate => PWM,       Linux_Nbr => 38,  Port => PE,  Reg_Bit => 6, Pinmux_Offset => 16#248#), 
       34   => (Default => GND,       Alternate => NIL),  
       35   => (Default => GPIO,      Alternate => I2S0_FS,   Linux_Nbr => 76,  Port => PJ,  Reg_Bit => 4, Pinmux_Offset => 16#144#),
       36   => (Default => GPIO,      Alternate => UART1_CTS, Linux_Nbr => 51,  Port => PG,  Reg_Bit => 3, Pinmux_Offset => 16#100#), 
       37   => (Default => GPIO,      Alternate => SPI1_MOSI, Linux_Nbr => 12,  Port => PB,  Reg_Bit => 4, Pinmux_Offset => 16#64#),
       38   => (Default => GPIO,      Alternate => I2S0_DIN,  Linux_Nbr => 77,  Port => PJ,  Reg_Bit => 5, Pinmux_Offset => 16#148#), 
       39   => (Default => GND,       Alternate => NIL),   
       40   => (Default => GPIO,      Alternate => I2S_DOUT,  Linux_Nbr => 78,  Port => PJ,  Reg_Bit => 6, Pinmux_Offset => 16#14C#));

    Type Bit Is Mod 2**1; 
    Type Two_Bits Is Mod 2**2;

    Type Pinmux_Control Is Record
        Pm         : Two_Bits;
        Pupd       : Two_Bits;
        Tristate   : Bit;
        Park       : Bit;
        E_Input    : Bit;
        Lock       : Bit;
        E_Hsm      : Bit;
        E_Schmt    : Bit;
        Drive_Type : Two_Bits;
    End Record;
    For Pinmux_Control'Size Use Kernel.U32'Size;

    For Pinmux_Control Use Record
        Pm         At 0 Range  0 ..  1;
        Pupd       At 0 Range  2 ..  3;
        Tristate   At 0 Range  4 ..  4;
        Park       At 0 Range  5 ..  5;
        E_Input    At 0 Range  6 ..  6;
        Lock       At 0 Range  7 ..  7;
        E_Hsm      At 0 Range  9 ..  9;
        E_Schmt    At 0 Range 12 .. 12;
        Drive_Type At 0 Range 13 .. 14;
    End Record;

    Pinmux_Base_Addr : System.Address := System'To_Address (16#7000_3000#);

    Type Gpio_Bit_Array Is Array (Register_Bit) Of Bit With Pack;

    Type Gpio_Control Is Record
        Bits : Gpio_Bit_Array;
        Locks : Gpio_Bit_Array;
    End Record;
    For Gpio_Control'Size Use Kernel.U32'Size;

    For Gpio_Control Use Record
        Bits  At 0 Range 0 .. 7; 
        Locks At 1 Range 0 .. 7;
    End Record;

    Type Register Is (GPIO_CNF, GPIO_OE, GPIO_OUT, GPIO_IN, GPIO_INT_STA, GPIO_INT_ENB, GPIO_INT_LVL, GPIO_INT_CLR);
    Type Registers_Offsets_Array Is Array (Register) Of Storage_Offset;

    Registers_Offsets : Constant Registers_Offsets_Array :=
    (GPIO_CNF       => 16#00#,
     GPIO_OE        => 16#10#,
     GPIO_OUT       => 16#20#,
     GPIO_IN        => 16#30#,
     GPIO_INT_STA   => 16#40#,
     GPIO_INT_ENB   => 16#50#,
     GPIO_INT_LVL   => 16#60#,
     GPIO_INT_CLR   => 16#70#);

    Function To_U32 Is New Ada.Unchecked_Conversion (Source => Gpio_Control, Target => Kernel.U32);

    Function Get_Bank_Phys_Address (Port : Gpio_Tegra_Port) Return System.Address Is
        (Gpio_Banks(Gpio_Tegra_Port'Pos(Port) / 4 + 1));

    Function Get_Register_Phys_Address (Port : Gpio_Tegra_Port; Reg : Register) Return System.Address Is
        (Get_Bank_Phys_Address (Port) + Registers_Offsets (Reg) + (Gpio_Tegra_Port'Pos(Port) Mod 4) * 4);

End Controllers;
