With Kernel;
With Interfaces.C;

Package Body Led Is

    Package Ic Renames Interfaces.C;

    Procedure Init (L : Led_Type) Is
        Res : Ic.Int;
    Begin
        Res := Kernel.Gpio_Request (Ic.Unsigned(L.Pin.Linux_Nbr), L.Label);
    End;

    Procedure Flip_State (L : in out Led_Type) is
        Value : Ic.Int := Kernel.Gpio_Get_Value (Ic.Unsigned(L.Pin.Linux_Nbr));
        Res   : Ic.Int;
    Begin
        L.S := State'Enum_Val(Value);
        Res := Kernel.Gpio_Direction_Output (Ic.Unsigned(L.Pin.Linux_Nbr), State'Enum_Rep (not L.S));
    End;

    Procedure Final (L : Led_Type) Is
    Begin
        Kernel.Gpio_Free (Ic.Unsigned(L.Pin.Linux_Nbr));
    End;

End Led;
