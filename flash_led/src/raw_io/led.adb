With Kernel;
With System;
With Ada.Unchecked_Conversion;

With Interfaces.C;

With System.Machine_Code;
With System.Storage_Elements;

With Controllers;
Package Body Led Is

   Package Ic Renames Interfaces.C;

   Function "+" (Addr : System.Address; Offset : System.Storage_Elements.Storage_Offset) Return Kernel.Phys_Addr_T Is
      Use System.Storage_Elements;
      Res : System.Address := Addr + Offset;
   Begin
      Return Kernel.Phys_Addr_T (Res);
   End;

   Function Ioremap (Phys_Addr : System.Address; Size : Ic.Size_T) Return Kernel.Iomem_Access Is
      Use Kernel;
   Begin
      Return Ioremap (Kernel.Phys_Addr_T(Phys_Addr), Size);
   End;

   Procedure Set_Pinmux (Pin : Controllers.Pin) Is
      Base_Addr   : Kernel.Iomem_Access := Kernel.Ioremap (Controllers.Pinmux_Base_Addr + Pin.Pinmux_Offset, 4);
   Begin
      Kernel.Io_Write_32 (0, Base_Addr);
   End;

   Procedure Set_Gpio (Pin : Controllers.Pin; S : Led.State) Is
      use Controllers;
      use Kernel;
      Base_Addr   : Kernel.Iomem_Access;
      Control     : Controllers.Gpio_Control := (Bits => (Others => 0), Locks => (Others => 0));
      Control_C   : Kernel.U32;
      For Control_C'Address use Control'Address;
   Begin
      Set_Pinmux (Pin);

      Control.Bits(Pin.Reg_Bit) := (If S = High Then 1 Else 0);

      Base_Addr   := Ioremap (Get_Register_Phys_Address (Pin.Port, GPIO_CNF), Control_C'Size);
      Io_Write_32 (Control_C, Base_Addr);

      Base_Addr   := Ioremap (Get_Register_Phys_Address (Pin.Port, GPIO_OE), Control_C'Size);
      Io_Write_32 (Control_C, Base_Addr);

      Base_Addr   := Ioremap (Get_Register_Phys_Address (Pin.Port, GPIO_OUT), Control_C'Size);
      Io_Write_32 (Control_C, Base_Addr);
   End;

   Procedure Init (L : Led_Type) Is
   Begin
      Set_Gpio (L.Pin, Low);
   End;

   Procedure Light (L : Led_Type; S : State) Is
   Begin
      Set_Gpio (L.Pin, S);
   End;

   Function Get_State (L : Led_Type) Return State Is
      Use Controllers;
      Use Kernel;
      Base_Addr : Kernel.Iomem_Access := Ioremap (Get_Register_Phys_Address (L.Pin.Port, GPIO_OUT), 4);
      Value     : Kernel.U32 := Io_Read_32 (Base_Addr);
      Data      : Controllers.Gpio_Control;
      For Data'Address Use Value'Address;
   Begin
      Return (If Data.Bits(L.Pin.Reg_Bit) = 1 Then High Else Low);
   End;

   Procedure Final (L : Led_Type) Is
   Begin
      Set_Gpio (L.Pin, Low);
   End;

End Led;
