with Interfaces.C;
with System;
with Time_H;
-- /home/henley/adacore/repos/test_c_to_ada_headers/python/kernel_interface/kernel-4.9/include/linux/jiffies.h
package Jiffies_H is

   jiffies : Interfaces.C.Unsigned_Long
   with Import => True,
        Convention => C,
        External_Name => "jiffies";

   -- jiffies.h:  59
   function Register_Refined_Jiffies (
      Clock_Tick_Rate : Interfaces.C.Long)
      return Interfaces.C.Int
   with Import => True,
        Convention => C,
        External_Name => "register_refined_jiffies";

   -- jiffies.h:  76
   Cacheline_Aligned_In_Smp : aliased Interfaces.C.Int
   with Import => True,
        Convention => C,
        External_Name => "__cacheline_aligned_in_smp";

   -- jiffies.h:  77
   -- jiffies.h:  80
   function Get_Jiffies_64 return Interfaces.C.Int
   with Import => True,
        Convention => C,
        External_Name => "get_jiffies_64";

   -- jiffies.h:  186
   Preset_Lpj : aliased Interfaces.C.Unsigned_Long
   with Import => True,
        Convention => C,
        External_Name => "preset_lpj";

   -- jiffies.h:  287
   function Jiffies_To_Msecs (
      J : Interfaces.C.Unsigned_Long)
      return Interfaces.C.Unsigned
   with Import => True,
        Convention => C,
        External_Name => "jiffies_to_msecs";

   -- jiffies.h:  288
   function Jiffies_To_Usecs (
      J : Interfaces.C.Unsigned_Long)
      return Interfaces.C.Unsigned
   with Import => True,
        Convention => C,
        External_Name => "jiffies_to_usecs";

   -- jiffies.h:  290
   function Jiffies_To_Nsecs return Interfaces.C.Int
   with Import => True,
        Convention => C,
        External_Name => "jiffies_to_nsecs";

   -- jiffies.h:  295
   function Jiffies64_To_Nsecs return Interfaces.C.Int
   with Import => True,
        Convention => C,
        External_Name => "jiffies64_to_nsecs";

   -- jiffies.h:  297
   function Msecs_To_Jiffies (
      M : Interfaces.C.Unsigned)
      return Interfaces.C.Unsigned_Long
   with Import => True,
        Convention => C,
        External_Name => "__msecs_to_jiffies";

   -- jiffies.h:  326
   function Msecs_To_Jiffies_1 (
      M : Interfaces.C.Unsigned)
      return Interfaces.C.Unsigned_Long
   with Import => True,
        Convention => C,
        External_Name => "_msecs_to_jiffies";

   -- jiffies.h:  359
   function Msecs_To_Jiffies_2 (
      M : Interfaces.C.Unsigned)
      return Interfaces.C.Unsigned_Long
   with Import => True,
        Convention => C,
        External_Name => "msecs_to_jiffies";

   -- jiffies.h:  370
   function Usecs_To_Jiffies (
      U : Interfaces.C.Unsigned)
      return Interfaces.C.Unsigned_Long
   with Import => True,
        Convention => C,
        External_Name => "__usecs_to_jiffies";

   -- jiffies.h:  372
   function Usecs_To_Jiffies_1 (
      U : Interfaces.C.Unsigned)
      return Interfaces.C.Unsigned_Long
   with Import => True,
        Convention => C,
        External_Name => "_usecs_to_jiffies";

   -- jiffies.h:  406
   function Usecs_To_Jiffies_2 (
      U : Interfaces.C.Unsigned)
      return Interfaces.C.Unsigned_Long
   with Import => True,
        Convention => C,
        External_Name => "usecs_to_jiffies";

   -- jiffies.h:  417
   function Timespec64_To_Jiffies (
      Value : System.Address)
      return Interfaces.C.Unsigned_Long
   with Import => True,
        Convention => C,
        External_Name => "timespec64_to_jiffies";

   -- jiffies.h:  418
   procedure Jiffies_To_Timespec64 (
      Jiffies : Interfaces.C.Unsigned_Long;
      Value : System.Address)
   with Import => True,
        Convention => C,
        External_Name => "jiffies_to_timespec64";

   -- jiffies.h:  420
   function Timespec_To_Jiffies (
      Value : access Time_H.Timespec)
      return Interfaces.C.Unsigned_Long
   with Import => True,
        Convention => C,
        External_Name => "timespec_to_jiffies";

   -- jiffies.h:  427
   procedure Jiffies_To_Timespec (
      Jiffies : Interfaces.C.Unsigned_Long;
      Value : access Time_H.Timespec)
   with Import => True,
        Convention => C,
        External_Name => "jiffies_to_timespec";

   -- jiffies.h:  436
   function Timeval_To_Jiffies (
      Value : access Time_H.Timeval)
      return Interfaces.C.Unsigned_Long
   with Import => True,
        Convention => C,
        External_Name => "timeval_to_jiffies";

   -- jiffies.h:  437
   procedure Jiffies_To_Timeval (
      Jiffies : Interfaces.C.Unsigned_Long;
      Value : access Time_H.Timeval)
   with Import => True,
        Convention => C,
        External_Name => "jiffies_to_timeval";

   -- jiffies.h:  440
   function Jiffies_To_Clock_T return Interfaces.C.Int
   with Import => True,
        Convention => C,
        External_Name => "jiffies_to_clock_t";

   -- jiffies.h:  441
   function Jiffies_Delta_To_Clock_T return Interfaces.C.Int
   with Import => True,
        Convention => C,
        External_Name => "jiffies_delta_to_clock_t";

   -- jiffies.h:  446
   function Clock_T_To_Jiffies (
      X : Interfaces.C.Unsigned_Long)
      return Interfaces.C.Unsigned_Long
   with Import => True,
        Convention => C,
        External_Name => "clock_t_to_jiffies";

   -- jiffies.h:  447
   function Jiffies_64_To_Clock_T return Interfaces.C.Int
   with Import => True,
        Convention => C,
        External_Name => "jiffies_64_to_clock_t";

   -- jiffies.h:  448
   function Nsec_To_Clock_T return Interfaces.C.Int
   with Import => True,
        Convention => C,
        External_Name => "nsec_to_clock_t";

   -- jiffies.h:  449
   function Nsecs_To_Jiffies64 return Interfaces.C.Int
   with Import => True,
        Convention => C,
        External_Name => "nsecs_to_jiffies64";

   -- jiffies.h:  450
   function Nsecs_To_Jiffies (
      N : Interfaces.C.Int)
      return Interfaces.C.Unsigned_Long
   with Import => True,
        Convention => C,
        External_Name => "nsecs_to_jiffies";

end Jiffies_H;
