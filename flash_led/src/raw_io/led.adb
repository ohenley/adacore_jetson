With Kernel;
With System;
With Ada.Unchecked_Conversion;

With Interfaces.C;

With System.Machine_Code;
With System.Storage_Elements; use System.Storage_Elements;

With Controllers;
Package Body Led Is

   Package Ic Renames Interfaces.C;
   Package K  Renames Kernel;

   Function "+" (Addr : System.Address; Offset : Storage_Offset) Return K.Phys_Addr_T Is
      Res : System.Address := Addr + Offset;
   Begin
      Return K.Phys_Addr_T (Res);
   End;

   Function Ioremap (Phys_Addr : System.Address; Size : Ic.Size_T) Return K.Iomem_Access Is
      (K.Ioremap (K.Phys_Addr_T (Phys_Addr), Size));

   Procedure Set_Pinmux (Pin : C.Pin) Is
      Base_Addr   : K.Iomem_Access := K.Ioremap (C.Pinmux_Base_Addr + Pin.Pinmux_Offset, 4);
   Begin
      K.Io_Write_32 (0, Base_Addr);
   End;

   Procedure Set_Gpio (Pin : C.Pin; S : Led.State) Is

      Function Bit(S: Led.State) Return C.Bit Renames Led.State'Enum_Rep;

      Base_Addr   : K.Iomem_Access;
      Control     : C.Gpio_Control := (Bits => (Others => 0), Locks => (Others => 0));
      Control_C   : K.U32;
      For Control_C'Address use Control'Address;
   Begin
      Set_Pinmux (Pin);

      Control.Bits(Pin.Reg_Bit) := Bit (S);

      Base_Addr   := Ioremap (C.Get_Register_Phys_Address (Pin.Port, C.GPIO_CNF), Control_C'Size);
      K.Io_Write_32 (Control_C, Base_Addr);

      Base_Addr   := Ioremap (C.Get_Register_Phys_Address (Pin.Port, C.GPIO_OE), Control_C'Size);
      K.Io_Write_32 (Control_C, Base_Addr);

      Base_Addr   := Ioremap (C.Get_Register_Phys_Address (Pin.Port, C.GPIO_OUT), Control_C'Size);
      K.Io_Write_32 (Control_C, Base_Addr);
   End;

   Procedure Init (L : Out Led_Type; P : C.Pin; T : Tag; S : State) Is
   Begin
      L.P := P;
      L.T := T;
      L.S := S;
      Set_Gpio (L.P, Low);
   End;

   Procedure Flip_State (L : In Out Led_Type) is
      Base_Addr : K.Iomem_Access := Ioremap (C.Get_Register_Phys_Address (L.P.Port, C.GPIO_OUT), 4);
      Value     : K.U32 := K.Io_Read_32 (Base_Addr);
      Data      : C.Gpio_Control;
      For Data'Address Use Value'Address;
   Begin
      L.S := State'Enum_Val (Data.Bits(L.P.Reg_Bit));
      Set_Gpio (L.P, not L.S);
   End;

   Procedure Final (L : Led_Type) Is
   Begin
      Set_Gpio (L.P, Low);
   End;

End Led;
