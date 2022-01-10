With Led; Use Led;

With System.Machine_Code;
With Ada.Unchecked_Conversion;
With Interfaces.C;


With Kernel;
With Controllers;

Package Body Flash_Led Is

    Package Ic Renames Interfaces.C;

    Half_Period_Ms : Ic.Unsigned := 500;

    Wq : Kernel.Workqueue_Struct_Access := Kernel.Workqueue_Struct_Access (System.Null_Address);
    Work : Kernel.Work_Struct;
    Timer : Kernel.Timer_List;
    Delayed_Work : Aliased Kernel.Delayed_Work;
    
    Pin : Controllers.Pin := Controllers.Jetson_Nano_Header_Pins(18);
    My_Led : Led_Type := (Pin => Pin, Label => "my_led");

    Procedure Work_Callback (Work : Kernel.Work_Struct_Access) With Convention => C;
    Procedure Work_Callback (Work : Kernel.Work_Struct_Access) Is
        Led_State : State := Get_State (My_Led);
    Begin
        Light (My_Led, Not Led_State);
        Kernel.Queue_Delayed_Work(Wq, Delayed_Work'Access, Kernel.Msecs_To_Jiffies (Half_Period_Ms));
    End;

    Procedure Setup_Delayed_Work Is
        Use Kernel;
        Function To_Unsigned_Long Is New Ada.Unchecked_Conversion (Source => Kernel.Delayed_Work_Access, Target => Ic.Unsigned_Long);
    Begin
        Work.Func := Work_Callback'Access;
        Work.Entryy.Prev := Delayed_Work.Work.Entryy'Access;
        Work.Entryy.Next := Delayed_Work.Work.Entryy'Access;
        Delayed_Work.Work := Work;

        Timer.Func := Kernel.Delayed_Work_Timer_Fn'Access;
        Timer.Expires := 0;
        Timer.Data := To_Unsigned_Long(Delayed_Work'Access);
        Delayed_Work.Timer := Timer;

        If Wq = Kernel.Null_Wq Then
            Wq := Kernel.Alloc_Workqueue ("flash_led_work");
        End If;

        If Wq /= Kernel.Null_Wq Then
            Kernel.Queue_Delayed_Work(Wq, Delayed_Work'Access, Kernel.Msecs_To_Jiffies (Half_Period_Ms));
        End If;

    End;

    Procedure Cleanup_Delayed_Work Is
        Use Kernel;
    Begin
        If Wq /= Kernel.Null_Wq Then
            Cancel_Delayed_Work (Delayed_Work'Access);
		    Flush_Workqueue (Wq);
		    Destroy_Workqueue (Wq);
        End If;
    End;

    Procedure Ada_Init_Module Is
        Procedure Ada_Linux_Init With
            Import        => True,
            Convention    => Ada,
            External_Name => "flash_ledinit"; 
    Begin
        Ada_Linux_Init;
        Init (My_Led);
        Setup_Delayed_Work;
    End;

    Procedure Ada_Cleanup_Module Is
    Begin
        Cleanup_Delayed_Work;
        Final (My_Led);
    End;
End Flash_Led;
