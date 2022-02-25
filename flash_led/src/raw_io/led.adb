with Kernel;
with System;
with Ada.Unchecked_Conversion;

with Interfaces.C;

with System.Machine_Code;
with System.Storage_Elements; use System.Storage_Elements;

with Controllers;
package body Led is

   package Ic renames Interfaces.C;
   package K renames Kernel;

   function "+" (Addr : System.Address; Offset : Storage_Offset) return K.Phys_Addr_T is
      Res : System.Address := Addr + Offset;
   begin
      return K.Phys_Addr_T (Res);
   end;

   function Ioremap (Phys_Addr : System.Address; Size : Ic.Size_T) return K.Iomem_Access is
     (K.Ioremap (K.Phys_Addr_T (Phys_Addr), Size));

   procedure Set_Pinmux (Pin : C.Pin_Data) is
      Base_Addr : K.Iomem_Access := K.Ioremap (C.Pinmux_Base_Addr + Pin.Pinmux_Offset, 4);
   begin
      K.Io_Write_32 (0, Base_Addr);
   end;

   procedure Set_Gpio (Pin : C.Pin_Data; S : Led.State) is

      function Bit (S : Led.State) return C.Bit renames Led.State'Enum_Rep;

      Base_Addr : K.Iomem_Access;
      Control   : C.Gpio_Control := (Bits => (others => 0), Locks => (others => 0));
      Control_C : K.U32;
      for Control_C'Address use Control'Address;
   begin
      Set_Pinmux (Pin);

      Control.Bits (Pin.Reg_Bit) := Bit (S);

      Base_Addr := Ioremap (C.Get_Register_Phys_Address (Pin.Port, C.GPIO_CNF), Control_C'Size);
      K.Io_Write_32 (Control_C, Base_Addr);

      Base_Addr := Ioremap (C.Get_Register_Phys_Address (Pin.Port, C.GPIO_OE), Control_C'Size);
      K.Io_Write_32 (Control_C, Base_Addr);

      Base_Addr := Ioremap (C.Get_Register_Phys_Address (Pin.Port, C.GPIO_OUT), Control_C'Size);
      K.Io_Write_32 (Control_C, Base_Addr);
   end;

   procedure Init (L : out Led_Type; P : C.Pin_Data; T : Tag; S : State) is
   begin
      L.P := P;
      L.T := T;
      L.S := S;
      Set_Gpio (L.P, Off);
   end;

   procedure Flip_State (L : in out Led_Type) is
      Base_Addr : K.Iomem_Access := Ioremap (C.Get_Register_Phys_Address (L.P.Port, C.GPIO_OUT), 4);
      Value : K.U32 := K.Io_Read_32 (Base_Addr);
      Data  : C.Gpio_Control;
      for Data'Address use Value'Address;
   begin
      L.S := State'Enum_Val (Data.Bits (L.P.Reg_Bit));
      Set_Gpio (L.P, not L.S);
   end;

   procedure Final (L : Led_Type) is
   begin
      Set_Gpio (L.P, Off);
   end;

end Led;
