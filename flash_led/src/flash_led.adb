with System;
with Ada.Unchecked_Conversion;
with Interfaces.C;

with Kernel;
with Controllers;
with Led; use Led;

package body Flash_Led is

   package IC renames Interfaces.C;
   package K renames Kernel;
   package C renames Controllers;
   generic function AUC renames Ada.Unchecked_Conversion;

   Half_Period_Ms : Ic.Unsigned := 500;

   Wq           : K.Wq_Struct_Access := K.Null_Wq;
   Work         : K.Work_Struct;
   Timer        : K.Timer_List;
   Delayed_Work : aliased K.Delayed_Work;

   Pin     : C.Pin_Data   := C.Jetson_Nano_Header_Pins (18);
   Led_Tag : Led.Tag := "my_led";
   My_Led  : Led_Type (Led_Tag'Size);

   procedure Work_Callback (Work : K.Work_Struct_Access) is
   begin
      Flip_State (My_Led);
      K.Queue_Delayed_Work (Wq, Delayed_Work'Access, K.Msecs_To_Jiffies (Half_Period_Ms));
   end;

   procedure Declare_Delayed_Work is
      function To_Unsigned_Long is new AUC (K.Delayed_Work_Access, IC.Unsigned_Long);
   begin
      Work.Func         := Work_Callback'Access;
      Work.Entryy.Prev  := Delayed_Work.Work.Entryy'Access;
      Work.Entryy.Next  := Delayed_Work.Work.Entryy'Access;
      Delayed_Work.Work := Work;

      Timer.Func         := K.Delayed_Work_Timer_Fn'Access;
      Timer.Expires      := 0;
      Timer.Data         := To_Unsigned_Long (Delayed_Work'Access);
      Delayed_Work.Timer := Timer;
   end;

   procedure Cleanup_Delayed_Work is
      use K;
   begin
      if Wq /= K.Null_Wq then
         Cancel_Delayed_Work (Delayed_Work'Access);
         Flush_Workqueue (Wq);
         Destroy_Workqueue (Wq);
      end if;
   end;

   procedure Ada_Init_Module is
      procedure Ada_Linux_Init with
         Import        => True,
         Convention    => Ada,
         External_Name => "flash_ledinit";
      use K;
   begin
      Ada_Linux_Init;

      Init (My_Led, P => Pin, T => Led_Tag, S => Off);
      Declare_Delayed_Work;

      if Wq = K.Null_Wq then
         Wq := K.Create_Singlethread_Wq ("flash_led_work");
      end if;

      if Wq /= K.Null_Wq then
         K.Queue_Delayed_Work
           (Wq, Delayed_Work'Access, K.Msecs_To_Jiffies (Half_Period_Ms));
      end if;
   end;

   procedure Ada_Cleanup_Module is
   begin
      Cleanup_Delayed_Work;
      Final (My_Led);
   end;
end;
