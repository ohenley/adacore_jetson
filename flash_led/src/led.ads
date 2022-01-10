With Controllers;
Package Led Is

    Type State Is (Low, High);
    For State Use (Low => 0, High => 1);

    Function "not" (S : State) Return State Is
        (If S = High Then Low Else High);

    Type Led_Type Is Record
        Pin : Controllers.Pin;
        Label : String (1 .. 6) := "my_led";
    End Record;

    Procedure Init (L : Led_Type);
    Procedure Light (L : Led_Type; S : State);
    Function Get_State (L : Led_Type) Return State;
    Procedure Final (L : Led_Type);

End Led;
