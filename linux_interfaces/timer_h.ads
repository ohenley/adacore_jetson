with Interfaces.C;
-- with Interfaces.C.Strings;
with System;
-- /home/henley/adacore/repos/test_c_to_ada_headers/python/kernel_interface/kernel-4.9/include/linux/timer.h
package Timer_H is
   -- timer.h:  10
   type Tvec_Base is null record 
      with Convention => C_Pass_By_Copy;
   -- timer.h:  12

   type hlist_node;
   type hlist_node_acc is access hlist_node;
   type hlist_node_acc_acc is access hlist_node_acc;

   type hlist_node is record
      next : hlist_node_acc;  -- /home/henley/adacore/repos/test_c_to_ada_headers/python/kernel_interface/kernel-4.9/include/linux/types.h:193
      pprev : hlist_node_acc_acc;  -- /home/henley/adacore/repos/test_c_to_ada_headers/python/kernel_interface/kernel-4.9/include/linux/types.h:193
   end record
   with Convention => C;

   type Timer_List_Function_T is access procedure  (
      Param_1 : Interfaces.C.Unsigned_Long)
   with Convention => C;
   type Timer_List is record
      C_Entry : Hlist_Node;
      Expires : Interfaces.C.Unsigned_Long;
      C_Function : Timer_List_Function_T;
      Data : Interfaces.C.Unsigned_Long;
      Flags : Interfaces.C.Int;
   end record
   with Convention => C_Pass_By_Copy;

   -- procedure setup_timer (
   --    Timer : access Timer_List;
   --    C_Function : Timer_List_Function_T;
   --    Data : Interfaces.C.Unsigned_Long;
   --    flags: Interfaces.C.Unsigned)
   -- with Import => True,
   --      Convention => C,
   --      External_Name => "__setup_timer";

   -- timer.h:  95
   procedure Init_Timer_Key (
      Timer : access Timer_List;
      Flags : Interfaces.C.Unsigned;
      Name : Interfaces.C.char_array;
      Key : System.Address)
   with Import => True,
        Convention => C,
        External_Name => "init_timer_key";

   -- timer.h:  104
   procedure Destroy_Timer_On_Stack (
      Timer : access Timer_List)
   with Import => True,
        Convention => C,
        External_Name => "destroy_timer_on_stack";

   -- timer.h:  105
   procedure Init_Timer_On_Stack_Key (
      Timer : access Timer_List;
      Flags : Interfaces.C.Unsigned;
      Name : Interfaces.C.char_array;
      Key : System.Address)
   with Import => True,
        Convention => C,
        External_Name => "init_timer_on_stack_key";

   -- timer.h:  184
   function Timer_Pending (
      Timer : access Timer_List)
      return Interfaces.C.Int
   with Import => True,
        Convention => C,
        External_Name => "timer_pending";

   -- timer.h:  189
   procedure Add_Timer_On (
      Timer : access Timer_List;
      Cpu : Interfaces.C.Int)
   with Import => True,
        Convention => C,
        External_Name => "add_timer_on";

   -- timer.h:  190
   function Del_Timer (
      Timer : access Timer_List)
      return Interfaces.C.Int
   with Import => True,
        Convention => C,
        External_Name => "del_timer";

   -- timer.h:  191
   function Mod_Timer (
      Timer : access Timer_List;
      Expires : Interfaces.C.Unsigned_Long)
      return Interfaces.C.Int
   with Import => True,
        Convention => C,
        External_Name => "mod_timer";

   -- timer.h:  192
   function Mod_Timer_Pending (
      Timer : access Timer_List;
      Expires : Interfaces.C.Unsigned_Long)
      return Interfaces.C.Int
   with Import => True,
        Convention => C,
        External_Name => "mod_timer_pending";

   -- timer.h:  227
   procedure Init_Timer_Stats
   with Import => True,
        Convention => C,
        External_Name => "init_timer_stats";

   -- timer.h:  231
   procedure Timer_Stats_Timer_Set_Start_Info (
      Timer : access Timer_List)
   with Import => True,
        Convention => C,
        External_Name => "timer_stats_timer_set_start_info";

   -- timer.h:  235
   procedure Timer_Stats_Timer_Clear_Start_Info (
      Timer : access Timer_List)
   with Import => True,
        Convention => C,
        External_Name => "timer_stats_timer_clear_start_info";

   -- timer.h:  240
   procedure Add_Timer (
      Timer : access Timer_List)
   with Import => True,
        Convention => C,
        External_Name => "add_timer";

   -- timer.h:  242
   function Try_To_Del_Timer_Sync (
      Timer : access Timer_List)
      return Interfaces.C.Int
   with Import => True,
        Convention => C,
        External_Name => "try_to_del_timer_sync";

   -- timer.h:  252
   procedure Init_Timers
   with Import => True,
        Convention => C,
        External_Name => "init_timers";

   -- timer.h:  253
   procedure Run_Local_Timers
   with Import => True,
        Convention => C,
        External_Name => "run_local_timers";

   -- timer.h:  254
   type Hrtimer is null record 
      with Convention => C_Pass_By_Copy;

   -- timer.h:  266
   function Round_Jiffies (
      J : Interfaces.C.Unsigned_Long;
      Cpu : Interfaces.C.Int)
      return Interfaces.C.Unsigned_Long
   with Import => True,
        Convention => C,
        External_Name => "__round_jiffies";

   -- timer.h:  267
   function Round_Jiffies_Relative (
      J : Interfaces.C.Unsigned_Long;
      Cpu : Interfaces.C.Int)
      return Interfaces.C.Unsigned_Long
   with Import => True,
        Convention => C,
        External_Name => "__round_jiffies_relative";

   -- timer.h:  268
   function Round_Jiffies_1 (
      J : Interfaces.C.Unsigned_Long)
      return Interfaces.C.Unsigned_Long
   with Import => True,
        Convention => C,
        External_Name => "round_jiffies";

   -- timer.h:  269
   function Round_Jiffies_Relative_1 (
      J : Interfaces.C.Unsigned_Long)
      return Interfaces.C.Unsigned_Long
   with Import => True,
        Convention => C,
        External_Name => "round_jiffies_relative";

   -- timer.h:  271
   function Round_Jiffies_Up (
      J : Interfaces.C.Unsigned_Long;
      Cpu : Interfaces.C.Int)
      return Interfaces.C.Unsigned_Long
   with Import => True,
        Convention => C,
        External_Name => "__round_jiffies_up";

   -- timer.h:  272
   function Round_Jiffies_Up_Relative (
      J : Interfaces.C.Unsigned_Long;
      Cpu : Interfaces.C.Int)
      return Interfaces.C.Unsigned_Long
   with Import => True,
        Convention => C,
        External_Name => "__round_jiffies_up_relative";

   -- timer.h:  273
   function Round_Jiffies_Up_1 (
      J : Interfaces.C.Unsigned_Long)
      return Interfaces.C.Unsigned_Long
   with Import => True,
        Convention => C,
        External_Name => "round_jiffies_up";

   -- timer.h:  274
   function Round_Jiffies_Up_Relative_1 (
      J : Interfaces.C.Unsigned_Long)
      return Interfaces.C.Unsigned_Long
   with Import => True,
        Convention => C,
        External_Name => "round_jiffies_up_relative";

end Timer_H;
