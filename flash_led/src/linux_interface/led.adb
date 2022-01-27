With Kernel;
With Interfaces.C;

Package Body Led Is

    Package Ic Renames Interfaces.C;

    Procedure Init (L : Out Led_Type; P : C.Pin; T : Tag; S : State) Is
        Res : Ic.Int;
    Begin
        L.P := P;
        L.T := T;
        L.S := S;
        Res := Kernel.Gpio_Request (Ic.Unsigned(L.P.Linux_Nbr), L.T);
    End;

    Procedure Flip_State (L : In Out Led_Type) is
        Value : Ic.Int := Kernel.Gpio_Get_Value (Ic.Unsigned(L.P.Linux_Nbr));
        Res   : Ic.Int;
    Begin
        L.S := State'Enum_Val(Value);
        Res := Kernel.Gpio_Direction_Output (Ic.Unsigned(L.P.Linux_Nbr), State'Enum_Rep (not L.S));
    End;

    Procedure Final (L : Led_Type) Is
    Begin
        Kernel.Gpio_Free (Ic.Unsigned(L.P.Linux_Nbr));
    End;

End Led;
