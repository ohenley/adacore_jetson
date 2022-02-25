with Kernel;
with Interfaces.C;

package body Led is

   package Ic renames Interfaces.C;

   procedure Init (L : out Led_Type; P : C.Pin_Data; T : Tag; S : State) is
      Res : Ic.Int;
   begin
      L.P := P;
      L.T := T;
      L.S := S;
      Res := Kernel.Gpio_Request (Ic.Unsigned (L.P.Linux_Nbr), L.T);
   end;

   procedure Flip_State (L : in out Led_Type) is
      Value : Ic.Int := Kernel.Gpio_Get_Value (Ic.Unsigned (L.P.Linux_Nbr));
      Res   : Ic.Int;
   begin
      L.S := State'Enum_Val (Value);
      Res := Kernel.Gpio_Direction_Output (Ic.Unsigned (L.P.Linux_Nbr), State'Enum_Rep (not L.S));
   end;

   procedure Final (L : Led_Type) is
   begin
      Kernel.Gpio_Free (Ic.Unsigned (L.P.Linux_Nbr));
   end;

end Led;
