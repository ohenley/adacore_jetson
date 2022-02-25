with System;
with Kernel;
with Ada.Unchecked_Conversion;
with System.Storage_Elements; use System.Storage_Elements;

package Controllers is

   package K renames Kernel;

   type Function_Type is
     (GPIO, VDC3_3, VDC5_0, GND, NIL, I2C0_SDA, I2C0_CLK, I2C1_SDA, I2C1_SCL,
      UART1_TXD, UART1_RXD, AUD_CLK, UART1_RTS, SPI1_SCK, SPI0_MOSI, SPI0_MISO,
      SPI0_SCK, SPI0_CS0, CAM_MCLK, PWM, I2S0_FS, SPI1_MOSI, I2S0_SCLK,
      SPI1_CS1, SPI1_CS0, SPI1_MISO, SPI0_CS1, UART1_CTS, I2S0_DIN, I2S_DOUT);

   type Gpio_Tegra_Port is
     (PA, PB, PC, PD, PE, PF, PG, PH, PI, PJ, PK, PL, PM, PN, PO, PP, PQ, PR,
      PS, PT, PU, PV, PW, PX, PY, PZ, PAA, PBB, PCC, PDD, PEE, NIL);

   type Gpio_Bank_Desc is range 1 .. 8;

   type Banks_Array is array (Gpio_Bank_Desc) of System.Address;

   Gpio_Banks : constant Banks_Array := (System'To_Address (16#6000_D000#), 
                                         System'To_Address (16#6000_D100#),
                                         System'To_Address (16#6000_D200#), 
                                         System'To_Address (16#6000_D300#),
                                         System'To_Address (16#6000_D400#), 
                                         System'To_Address (16#6000_D500#),
                                         System'To_Address (16#6000_D600#), 
                                         System'To_Address (16#6000_D700#));

   type Jetson_Nano_Header_Pin is range 1 .. 40; -- Jetson Nano Physical Expansion Pinout
   type Gpio_Linux_Nbr is range 0 .. 255;        -- sudo cat /sys/kernel/debug/gpio
   type Gpio_Tegra_Register_Bit is range 0 .. 7;

   type Pin_Data (Default : Function_Type := GPIO) is record
      Alt : Function_Type := GPIO;
      case Default is
         when VDC3_3 .. GND =>
            null;
         when others =>
            Linux_Nbr     : Gpio_Linux_Nbr;
            Port          : Gpio_Tegra_Port;
            Reg_Bit       : Gpio_Tegra_Register_Bit;
            Pinmux_Offset : Storage_Offset;
      end case;
   end record;

   type Jetson_Nano_Pin_Data_Array is array (Jetson_Nano_Header_Pin) of Pin_Data;

   Jetson_Nano_Header_Pins : constant Jetson_Nano_Pin_Data_Array :=
     (1  => (Default => VDC3_3,    Alt => NIL),
      2  => (Default => VDC5_0,    Alt => NIL),
      3  => (Default => I2C1_SDA,  Alt => GPIO,      Linux_Nbr => 75,  Port => PJ,  Reg_Bit => 3, Pinmux_Offset => 16#C8#),
      4  => (Default => VDC5_0,    Alt => NIL),
      5  => (Default => I2C1_SCL,  Alt => GPIO,      Linux_Nbr => 74,  Port => PJ,  Reg_Bit => 2, Pinmux_Offset => 16#C4#),
      6  => (Default => GND,       Alt => NIL),
      7  => (Default => GPIO,      Alt => AUD_CLK,   Linux_Nbr => 216, Port => PBB, Reg_Bit => 0, Pinmux_Offset => 16#180#),
      8  => (Default => UART1_TXD, Alt => GPIO,      Linux_Nbr => 48,  Port => PG,  Reg_Bit => 0, Pinmux_Offset => 16#F4#),
      9  => (Default => GND,       Alt => NIL),
      10 => (Default => UART1_RXD, Alt => GPIO,      Linux_Nbr => 49,  Port => PG,  Reg_Bit => 1, Pinmux_Offset => 16#F8#),
      11 => (Default => GPIO,      Alt => UART1_RTS, Linux_Nbr => 50,  Port => PG,  Reg_Bit => 2, Pinmux_Offset => 16#FC#),
      12 => (Default => GPIO,      Alt => I2S0_SCLK, Linux_Nbr => 79,  Port => PJ,  Reg_Bit => 7, Pinmux_Offset => 16#150#),
      13 => (Default => GPIO,      Alt => SPI1_SCK,  Linux_Nbr => 14,  Port => PB,  Reg_Bit => 6, Pinmux_Offset => 16#6C#),
      14 => (Default => GND,       Alt => NIL),
      15 => (Default => GPIO,      Alt => NIL,       Linux_Nbr => 194, Port => PY,  Reg_Bit => 2, Pinmux_Offset => 16#1F8#),
      16 => (Default => GPIO,      Alt => SPI1_CS1,  Linux_Nbr => 232, Port => PDD, Reg_Bit => 0, Pinmux_Offset => 16#74#),
      17 => (Default => VDC3_3,    Alt => NIL),
      18 => (Default => GPIO,      Alt => SPI1_CS0,  Linux_Nbr => 15,  Port => PB,  Reg_Bit => 7, Pinmux_Offset => 16#70#),
      19 => (Default => GPIO,      Alt => SPI0_MOSI, Linux_Nbr => 16,  Port => PC,  Reg_Bit => 0, Pinmux_Offset => 16#50#),
      20 => (Default => GND,       Alt => NIL),
      21 => (Default => GPIO,      Alt => SPI0_MISO, Linux_Nbr => 17,  Port => PC,  Reg_Bit => 1, Pinmux_Offset => 16#54#),
      22 => (Default => GPIO,      Alt => SPI1_MISO, Linux_Nbr => 13,  Port => PB,  Reg_Bit => 5, Pinmux_Offset => 16#68#),
      23 => (Default => GPIO,      Alt => SPI0_SCK,  Linux_Nbr => 18,  Port => PC,  Reg_Bit => 2, Pinmux_Offset => 16#58#),
      24 => (Default => GPIO,      Alt => SPI0_CS0,  Linux_Nbr => 19,  Port => PC,  Reg_Bit => 3, Pinmux_Offset => 16#5C#),
      25 => (Default => GND,       Alt => NIL), 
      26 => (Default => GPIO,      Alt => SPI0_CS1,  Linux_Nbr => 20,  Port => PC,  Reg_Bit => 4, Pinmux_Offset => 16#60#),
      27 => (Default => I2C0_SDA,  Alt => GPIO,      Linux_Nbr => 13,  Port => PB,  Reg_Bit => 5, Pinmux_Offset => 16#C0#),
      28 => (Default => I2C0_CLK,  Alt => GPIO,      Linux_Nbr => 18,  Port => PC,  Reg_Bit => 2, Pinmux_Offset => 16#BC#),
      29 => (Default => GPIO,      Alt => CAM_MCLK,  Linux_Nbr => 149, Port => PS,  Reg_Bit => 5, Pinmux_Offset => 16#1E4#),
      30 => (Default => GND,       Alt => NIL), 
      31 => (Default => GPIO,      Alt => CAM_MCLK,  Linux_Nbr => 200, Port => PZ,  Reg_Bit => 0, Pinmux_Offset => 16#27C#),
      32 => (Default => GPIO,      Alt => PWM,       Linux_Nbr => 168, Port => PV,  Reg_Bit => 0, Pinmux_Offset => 16#1FC#),
      33 => (Default => GPIO,      Alt => PWM,       Linux_Nbr => 38,  Port => PE,  Reg_Bit => 6, Pinmux_Offset => 16#248#),
      34 => (Default => GND,       Alt => NIL), 
      35 => (Default => GPIO,      Alt => I2S0_FS,   Linux_Nbr => 76,  Port => PJ,  Reg_Bit => 4, Pinmux_Offset => 16#144#),
      36 => (Default => GPIO,      Alt => UART1_CTS, Linux_Nbr => 51,  Port => PG,  Reg_Bit => 3, Pinmux_Offset => 16#100#),
      37 => (Default => GPIO,      Alt => SPI1_MOSI, Linux_Nbr => 12,  Port => PB,  Reg_Bit => 4, Pinmux_Offset => 16#64#),
      38 => (Default => GPIO,      Alt => I2S0_DIN,  Linux_Nbr => 77,  Port => PJ,  Reg_Bit => 5, Pinmux_Offset => 16#148#),
      39 => (Default => GND,       Alt => NIL), 
      40 => (Default => GPIO,      Alt => I2S_DOUT,  Linux_Nbr => 78,  Port => PJ,  Reg_Bit => 6, Pinmux_Offset => 16#14C#));

   type Bit is mod 2**1;
   type Two_Bits is mod 2**2;

   type Pinmux_Control is record
      Pm         : Two_Bits;
      Pupd       : Two_Bits;
      Tristate   : Bit;
      Park       : Bit;
      E_Input    : Bit;
      Lock       : Bit;
      E_Hsm      : Bit;
      E_Schmt    : Bit;
      Drive_Type : Two_Bits;
   end record;
   for Pinmux_Control'Size use K.U32'Size;

   for Pinmux_Control use record
      Pm         at 0 range  0 ..  1;
      Pupd       at 0 range  2 ..  3;
      Tristate   at 0 range  4 ..  4;
      Park       at 0 range  5 ..  5;
      E_Input    at 0 range  6 ..  6;
      Lock       at 0 range  7 ..  7;
      E_Hsm      at 0 range  9 ..  9;
      E_Schmt    at 0 range 12 .. 12;
      Drive_Type at 0 range 13 .. 14;
   end record;

   Pinmux_Base_Addr : System.Address := System'To_Address (16#7000_3000#);

   type Gpio_Bit_Array is array (Gpio_Tegra_Register_Bit) of Bit with Pack;

   type Gpio_Control is record
      Bits  : Gpio_Bit_Array;
      Locks : Gpio_Bit_Array;
   end record;
   for Gpio_Control'Size use K.U32'Size;

   for Gpio_Control use record
      Bits  at 0 range 0 .. 7;
      Locks at 1 range 0 .. 7;
   end record;

   type Register is
     (GPIO_CNF, GPIO_OE, GPIO_OUT, GPIO_IN, GPIO_INT_STA, GPIO_INT_ENB, GPIO_INT_LVL, GPIO_INT_CLR);
   type Registers_Offsets_Array is array (Register) of Storage_Offset;

   Registers_Offsets : constant Registers_Offsets_Array := (GPIO_CNF     => 16#00#, 
                                                            GPIO_OE      => 16#10#, 
                                                            GPIO_OUT     => 16#20#,
                                                            GPIO_IN      => 16#30#, 
                                                            GPIO_INT_STA => 16#40#, 
                                                            GPIO_INT_ENB => 16#50#,
                                                            GPIO_INT_LVL => 16#60#, 
                                                            GPIO_INT_CLR => 16#70#);

   function To_U32 is new Ada.Unchecked_Conversion (Source => Gpio_Control, Target => K.U32);

   function Get_Bank_Phys_Address (Port : Gpio_Tegra_Port) return System.Address is
       (Gpio_Banks (Gpio_Tegra_Port'Pos (Port) / 4 + 1));

   function Get_Register_Phys_Address (Port : Gpio_Tegra_Port; Reg : Register) return System.Address is
       (Get_Bank_Phys_Address (Port) + Registers_Offsets (Reg) +
       (Gpio_Tegra_Port'Pos (Port) mod 4) * 4);

end Controllers;
