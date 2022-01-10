With Kernel;
With Interfaces.C;

Package Body Led Is

    Package Ic Renames Interfaces.C;

    Procedure Init (L : Led_Type) Is
        Res : Ic.Int;
    Begin
        Res := Kernel.Gpio_Request (Ic.Unsigned(L.Pin.Linux_Nbr), L.Label);
    End;

    Procedure Light (L : Led_Type; S : State) Is
        Res : Ic.Int;
    Begin
        Res := Kernel.Gpio_Direction_Output (Ic.Unsigned(L.Pin.Linux_Nbr), Ic.Int(State'Enum_Rep (S)));
    End;

    Function Get_State (L : Led_Type) Return State Is
        Value : Ic.Int;
    Begin
        Value := Kernel.Gpio_Get_Value (Ic.Unsigned(L.Pin.Linux_Nbr));
        Return State'Enum_Val(Value);
    End;

    Procedure Final (L : Led_Type) Is
    Begin
        Kernel.Gpio_Free (Ic.Unsigned(L.Pin.Linux_Nbr));
    End;

End Led;
