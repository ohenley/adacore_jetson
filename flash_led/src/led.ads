With Controllers;
Package Led Is

    Type State Is (Low, High);
    For State Use (Low => 0, High => 1);

    Function "not" (S : State) Return State Is
        (If S = High Then Low Else High);

    Type Led_Type Is Record
        Pin   : Controllers.Pin;
        Label : String (1 .. 6) := "my_led";
        S     : State := Low;
    End Record;

    Procedure Init       (L : Led_Type);
    Procedure Flip_State (L : in out Led_Type);
    Procedure Final      (L : Led_Type);

End Led;
