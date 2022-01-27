With System;
With Ada.Unchecked_Conversion;
With Interfaces.C;

With Kernel;
With Controllers;
With Led; Use Led;

Package Body Flash_Led Is

    Package  IC  Renames Interfaces.C;
    Package  K   Renames Kernel;
    Package  C   Renames Controllers;
    Generic Function AUC renames Ada.Unchecked_Conversion;

    Half_Period_Ms : Ic.Unsigned := 500;

    Wq           : K.Workqueue_Struct_Access := K.Null_Wq;
    Work         : K.Work_Struct;
    Timer        : K.Timer_List;
    Delayed_Work : Aliased K.Delayed_Work;

    Pin          : C.Pin := C.Jetson_Nano_Header_Pins (18);
    Led_Tag      : Led.Tag := "my_led";
    My_Led       : Led_Type (Led_Tag'Size);

    Procedure Work_Callback (Work : K.Work_Struct_Access) Is
    Begin
        My_Led.Flip_State;
        K.Queue_Delayed_Work (Wq, 
                              Delayed_Work'Access, 
                              K.Msecs_To_Jiffies (Half_Period_Ms));
    End;

    Procedure Declare_Delayed_Work Is
        Function To_Unsigned_Long Is New AUC 
            (K.Delayed_Work_Access, IC.Unsigned_Long);
    Begin
        Work.Func := Work_Callback'Access;
        Work.Entryy.Prev := Delayed_Work.Work.Entryy'Access;
        Work.Entryy.Next := Delayed_Work.Work.Entryy'Access;
        Delayed_Work.Work := Work;

        Timer.Func := K.Delayed_Work_Timer_Fn'Access;
        Timer.Expires := 0;
        Timer.Data := To_Unsigned_Long (Delayed_Work'Access);
        Delayed_Work.Timer := Timer;
    End;

    Procedure Cleanup_Delayed_Work Is
        Use K;
    Begin
        If Wq /= K.Null_Wq Then
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
        use K;
    Begin
        Ada_Linux_Init;
        My_Led.Init (P => Pin, T => Led_Tag, S => Low);
        Declare_Delayed_Work;

        If Wq = K.Null_Wq Then
            Wq := K.Create_Singlethread_Wq ("flash_led_work");
        End If;

        If Wq /= K.Null_Wq Then
            K.Queue_Delayed_Work(Wq, Delayed_Work'Access, K.Msecs_To_Jiffies (Half_Period_Ms));
        End If;
    End;

    Procedure Ada_Cleanup_Module Is
    Begin
        Cleanup_Delayed_Work;
        My_Led.Final;
    End;
End Flash_Led;
