with Interfaces.C;
with Interfaces.C.Strings;
with System;
-- /home/henley/cross/linux/include/linux/printk.h
package Printk_H is
   -- printk.h:  12
   type Linux_Banner_T is array ( 0 .. 0 ) of aliased Interfaces.C.Char;
   Linux_Banner : aliased Linux_Banner_T
   with Import => True,
        Convention => C,
        External_Name => "linux_banner";

   -- printk.h:  13
   type Linux_Proc_Banner_T is array ( 0 .. 0 ) of aliased Interfaces.C.Char;
   Linux_Proc_Banner : aliased Linux_Proc_Banner_T
   with Import => True,
        Convention => C,
        External_Name => "linux_proc_banner";

   -- printk.h:  15
   Oops_In_Progress : aliased Interfaces.C.Int
   with Import => True,
        Convention => C,
        External_Name => "oops_in_progress";

   -- printk.h:  19
   function Printk_Get_Level (
      Buffer : Interfaces.C.Strings.Chars_Ptr)
      return Interfaces.C.Int
   with Import => True,
        Convention => C,
        External_Name => "printk_get_level";

   -- printk.h:  31
   function Printk_Skip_Level (
      Buffer : Interfaces.C.Strings.Chars_Ptr)
      return Interfaces.C.Strings.Chars_Ptr
   with Import => True,
        Convention => C,
        External_Name => "printk_skip_level";

   -- printk.h:  39
   function Printk_Skip_Headers (
      Buffer : Interfaces.C.Strings.Chars_Ptr)
      return Interfaces.C.Strings.Chars_Ptr
   with Import => True,
        Convention => C,
        External_Name => "printk_skip_headers";

   -- printk.h:  65
   type Console_Printk_T is array ( 0 .. 0 ) of aliased Interfaces.C.Int;
   Console_Printk : aliased Console_Printk_T
   with Import => True,
        Convention => C,
        External_Name => "console_printk";

   -- printk.h:  72
   procedure Console_Silent
   with Import => True,
        Convention => C,
        External_Name => "console_silent";

   -- printk.h:  77
   procedure Console_Verbose
   with Import => True,
        Convention => C,
        External_Name => "console_verbose";

   -- printk.h:  85
   type Devkmsg_Log_Str_T is array ( 0 .. 0 ) of aliased Interfaces.C.Char;
   Devkmsg_Log_Str : aliased Devkmsg_Log_Str_T
   with Import => True,
        Convention => C,
        External_Name => "devkmsg_log_str";

   -- printk.h:  86
   type Ctl_Table is null record 
      with Convention => C_Pass_By_Copy;
   -- printk.h:  88
   Suppress_Printk : aliased Interfaces.C.Int
   with Import => True,
        Convention => C,
        External_Name => "suppress_printk";

   -- printk.h:  90
   type Va_Format is record
      Fmt : Interfaces.C.Strings.Chars_Ptr;
      Va : access Interfaces.C.Int;
   end record
   with Convention => C_Pass_By_Copy;

   -- printk.h:  213
   function Printf return Interfaces.C.Int
   with Import => True,
        Convention => C,
        External_Name => "__printf";

   -- printk.h:  214
   function Vprintk (
      S : Interfaces.C.char_array;
      Args : Interfaces.C.Int)
      return Interfaces.C.Int
   with Import => True,
        Convention => C,
        External_Name => "vprintk";

   -- printk.h:  565
   type File_Operations is null record 
      with Convention => C_Pass_By_Copy;
   -- printk.h:  565
   Kmsg_Fops : aliased File_Operations
   with Import => True,
        Convention => C,
        External_Name => "kmsg_fops";

   -- printk.h:  567
   type Anonymous_At_Printk_H_567_1 is (
      DUMP_PREFIX_NONE,
      DUMP_PREFIX_ADDRESS,
      DUMP_PREFIX_OFFSET)
   with Convention => C;

   -- printk.h:  572
   function Hex_Dump_To_Buffer (
      Buf : System.Address;
      Len : Interfaces.C.Int;
      Rowsize : Interfaces.C.Int;
      Groupsize : Interfaces.C.Int;
      Linebuf : Interfaces.C.Strings.Chars_Ptr;
      Linebuflen : Interfaces.C.Int;
      Ascii : Interfaces.C.Int)
      return Interfaces.C.Int
   with Import => True,
        Convention => C,
        External_Name => "hex_dump_to_buffer";

   -- printk.h:  580
   procedure Print_Hex_Dump (
      Level : Interfaces.C.Strings.Chars_Ptr;
      Prefix_Str : Interfaces.C.Strings.Chars_Ptr;
      Prefix_Type : Interfaces.C.Int;
      Rowsize : Interfaces.C.Int;
      Groupsize : Interfaces.C.Int;
      Buf : System.Address;
      Len : Interfaces.C.Int;
      Ascii : Interfaces.C.Int)
   with Import => True,
        Convention => C,
        External_Name => "print_hex_dump";

   -- printk.h:  585
   procedure Print_Hex_Dump_Bytes (
      Prefix_Str : Interfaces.C.Strings.Chars_Ptr;
      Prefix_Type : Interfaces.C.Int;
      Buf : System.Address;
      Len : Interfaces.C.Int)
   with Import => True,
        Convention => C,
        External_Name => "print_hex_dump_bytes";

   -- printk.h:  604
   procedure Print_Hex_Dump_Debug (
      Prefix_Str : Interfaces.C.Strings.Chars_Ptr;
      Prefix_Type : Interfaces.C.Int;
      Rowsize : Interfaces.C.Int;
      Groupsize : Interfaces.C.Int;
      Buf : System.Address;
      Len : Interfaces.C.Int;
      Ascii : Interfaces.C.Int)
   with Import => True,
        Convention => C,
        External_Name => "print_hex_dump_debug";

end Printk_H;
