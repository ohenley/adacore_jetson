with Interfaces.C;
with Posix_Types_H;
-- /usr/include/linux/time.h
package Time_H is
   -- time.h:  10
   type Timespec is record
      Tv_Sec : Posix_Types_H.Kernel_Time_T;
      Tv_Nsec : Interfaces.C.Long;
   end record
   with Convention => C_Pass_By_Copy;

   -- time.h:  16
   type Timeval is record
      Tv_Sec : Posix_Types_H.Kernel_Time_T;
      Tv_Usec : Posix_Types_H.Kernel_Suseconds_T;
   end record
   with Convention => C_Pass_By_Copy;

   -- time.h:  21
   type Timezone is record
      Tz_Minuteswest : Interfaces.C.Int;
      Tz_Dsttime : Interfaces.C.Int;
   end record
   with Convention => C_Pass_By_Copy;

   -- time.h:  34
   type Itimerspec is record
      It_Interval : Timespec;
      It_Value : Timespec;
   end record
   with Convention => C_Pass_By_Copy;

   -- time.h:  39
   type Itimerval is record
      It_Interval : Timeval;
      It_Value : Timeval;
   end record
   with Convention => C_Pass_By_Copy;

end Time_H;
