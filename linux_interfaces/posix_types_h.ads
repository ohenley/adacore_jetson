with Interfaces.C;
-- /usr/include/asm-generic/posix_types.h
package Posix_Types_H is
   -- posix_types.h:  15
   subtype Kernel_Long_T is Interfaces.C.Long;

   -- posix_types.h:  16
   subtype Kernel_Ulong_T is Interfaces.C.Unsigned_Long;

   -- posix_types.h:  20
   subtype Kernel_Ino_T is Kernel_Ulong_T;

   -- posix_types.h:  24
   subtype Kernel_Mode_T is Interfaces.C.Unsigned;

   -- posix_types.h:  28
   subtype Kernel_Pid_T is Interfaces.C.Int;

   -- posix_types.h:  32
   subtype Kernel_Ipc_Pid_T is Interfaces.C.Int;

   -- posix_types.h:  36
   subtype Kernel_Uid_T is Interfaces.C.Unsigned;

   -- posix_types.h:  37
   subtype Kernel_Gid_T is Interfaces.C.Unsigned;

   -- posix_types.h:  41
   subtype Kernel_Suseconds_T is Kernel_Long_T;

   -- posix_types.h:  45
   subtype Kernel_Daddr_T is Interfaces.C.Int;

   -- posix_types.h:  49
   subtype Kernel_Uid32_T is Interfaces.C.Unsigned;

   -- posix_types.h:  50
   subtype Kernel_Gid32_T is Interfaces.C.Unsigned;

   -- posix_types.h:  54
   subtype Kernel_Old_Uid_T is Kernel_Uid_T;

   -- posix_types.h:  55
   subtype Kernel_Old_Gid_T is Kernel_Gid_T;

   -- posix_types.h:  59
   subtype Kernel_Old_Dev_T is Interfaces.C.Unsigned;

   -- posix_types.h:  72
   subtype Kernel_Size_T is Kernel_Ulong_T;

   -- posix_types.h:  73
   subtype Kernel_Ssize_T is Kernel_Long_T;

   -- posix_types.h:  74
   subtype Kernel_Ptrdiff_T is Kernel_Long_T;

   -- posix_types.h:  79
   type Anonymous_At_Posix_Types_H_79_9_Val_T is array ( 0 .. 1 ) of aliased Interfaces.C.Int;
   type Anonymous_At_Posix_Types_H_79_9 is record
      Val : Anonymous_At_Posix_Types_H_79_9_Val_T;
   end record
   with Convention => C_Pass_By_Copy;

   -- posix_types.h:  81
   subtype Kernel_Fsid_T is Anonymous_At_Posix_Types_H_79_9;

   -- posix_types.h:  87
   subtype Kernel_Off_T is Kernel_Long_T;

   -- posix_types.h:  88
   subtype Kernel_Loff_T is Interfaces.C.Long_Long;

   -- posix_types.h:  89
   subtype Kernel_Time_T is Kernel_Long_T;

   -- posix_types.h:  90
   subtype Kernel_Time64_T is Interfaces.C.Long_Long;

   -- posix_types.h:  91
   subtype Kernel_Clock_T is Kernel_Long_T;

   -- posix_types.h:  92
   subtype Kernel_Timer_T is Interfaces.C.Int;

   -- posix_types.h:  93
   subtype Kernel_Clockid_T is Interfaces.C.Int;

   -- posix_types.h:  94
   type Kernel_Caddr_T is access all Interfaces.C.Char;

   -- posix_types.h:  95
   subtype Kernel_Uid16_T is Interfaces.C.Unsigned_Short;

   -- posix_types.h:  96
   subtype Kernel_Gid16_T is Interfaces.C.Unsigned_Short;

end Posix_Types_H;
