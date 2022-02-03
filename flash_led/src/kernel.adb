with Ada.Unchecked_Conversion;
with System.Machine_Code;
package body Kernel is

   type Bool is (NO, YES) with Size => 1;
   for Bool use (NO => 0, YES => 1);
   --for Bool'Size use 1;

   procedure Printk_C (S : String) with
      Import        => True,
      Convention    => C,
      External_Name => "printk";

   procedure Printk (S : String) is
   begin
      Printk_C (S & Ascii.Lf & Ascii.Nul);
   end;

   procedure Print_Access_Hex_C (A : System.Address) with
      Import        => True,
      Convention    => C,
      External_Name => "print_access_hex";

   procedure Printk (A : System.Address) is
   begin
      Print_Access_Hex_C (A);
   end;

   Type Gpio_Desc_Acc Is New System.Address;

   function Gpio_To_Desc_C (Gpio : Ic.Unsigned) return Gpio_Desc_Acc with
      Import        => True,
      Convention    => C,
      External_Name => "gpio_to_desc";

   function Gpiod_Direction_Output_Raw_C
     (Desc : Gpio_Desc_Acc; Value : Ic.Int) return Ic.Int with
      Import        => True,
      Convention    => C,
      External_Name => "gpiod_direction_output_raw";

   function Gpiod_Get_Raw_Value_C (Desc : Gpio_Desc_Acc) return Ic.Int with
      Import        => True,
      Convention    => C,
      External_Name => "gpiod_get_raw_value";

   function Gpio_Request_C
     (Gpio : Ic.Unsigned; Label : String) return Ic.Int with
      Import        => True,
      Convention    => C,
      External_Name => "gpio_request";

   function Gpio_Request (Gpio : Ic.Unsigned; Label : String) return Ic.Int is
   begin
      return Gpio_Request_C (Gpio, Label & Ascii.Lf & Ascii.Nul);
   end;

   function Gpio_Direction_Output (Gpio : Ic.Unsigned; Value : Ic.Int) return Ic.Int
   is
      Desc : Gpio_Desc_Acc := Gpio_To_Desc_C (Gpio);
   begin
      return Gpiod_Direction_Output_Raw_C (Desc, Value);
   end;

   function Gpio_Get_Value (Gpio : Ic.Unsigned) return Ic.Int is
      Desc : Gpio_Desc_Acc := Gpio_To_Desc_C (Gpio);
   begin
      return Gpiod_Get_Raw_Value_C (Desc);
   end;

   procedure Gpio_Free_C (Gpio : Ic.Unsigned) with
      Import        => True,
      Convention    => C,
      External_Name => "gpio_free";

   procedure Gpio_Free (Gpio : Ic.Unsigned) is
   begin
      Gpio_Free_C (Gpio);
   end;

   function Msecs_To_Jiffies_C (M : Ic.Unsigned) return Ic.Unsigned_Long with
      Import        => True,
      Convention    => C,
      External_Name => "__msecs_to_jiffies";

   function Msecs_To_Jiffies (M : Ic.Unsigned) return Ic.Unsigned_Long is
   begin
      return Msecs_To_Jiffies_C (M);
   end;

   type Pgprot_T is mod 2**64;
   for Pgprot_T'Size use 64;
   function Ioremap_C
     (Phys_Addr : Phys_Addr_T; Size : Ic.Size_T; Pgprot : Pgprot_T)
      return Iomem_Access with
      Import        => True,
      Convention    => C,
      External_Name => "__ioremap";

   function Ioremap (Phys_Addr : Phys_Addr_T; Size : Ic.Size_T) return Iomem_Access is
      type Memory_T is range 0 .. 5;

      MT_DEVICE_NGnRnE : Memory_T := 0;
      MT_DEVICE_NGnRE  : Memory_T := 1;
      MT_DEVICE_GRE    : Memory_T := 2;
      MT_NORMAL_NC     : Memory_T := 3;
      MT_NORMAL        : Memory_T := 4;
      MT_NORMAL_WT     : Memory_T := 5;

      function PTE_ATTRINDX (Mt : Memory_T) return Pgprot_T is 
         (Pgprot_T (Mt * 2#1#e+2));

      -- Page Table Entry
      PTE_VALID      : Pgprot_T := 2#1#e+0;
      PTE_WRITE      : Pgprot_T := 2#1#e+51;
      PTE_DIRTY      : Pgprot_T := 2#1#e+55;
      PTE_SPECIAL    : Pgprot_T := 2#1#e+56;
      PTE_PROT_NONE  : Pgprot_T := 2#1#e+58;
      PTE_TYPE_MASK  : Pgprot_T := 2#1#e+0 + 2#1#e+1;
      PTE_TYPE_FAULT : Pgprot_T := 2#0#e+0;
      PTE_TYPE_PAGE  : Pgprot_T := 2#1#e+0 + 2#1#e+1;
      PTE_TABLE_BIT  : Pgprot_T := 2#1#e+1;
      PTE_USER       : Pgprot_T := 2#1#e+6;
      PTE_RDONLY     : Pgprot_T := 2#1#e+7;
      PTE_SHARED     : Pgprot_T := 2#1#e+8 + 2#1#e+9;  -- Inner Shareable
      PTE_AF         : Pgprot_T := 2#1#e+10;           -- Access Flag
      PTE_NG         : Pgprot_T := 2#1#e+11;           -- NG
      PTE_DBM        : Pgprot_T := 2#1#e+51;           -- Dirty Bit Management
      PTE_CONT       : Pgprot_T := 2#1#e+52;           -- Contiguous Range
      PTE_PXN        : Pgprot_T := 2#1#e+53;           -- Privileged XN
      PTE_UXN        : Pgprot_T := 2#1#e+54;           -- User XN
      PTE_HYP_XN     : Pgprot_T := 2#1#e+54;           -- HYP XN

      Pgprot : Pgprot_T := (PTE_TYPE_MASK or 
                            PTE_AF        or 
                            PTE_SHARED    or 
                            PTE_PXN       or 
                            PTE_UXN       or
                            PTE_DIRTY     or 
                            PTE_DBM       or 
                            PTE_ATTRINDX (MT_DEVICE_NGnRE));
   begin
      return Ioremap_C (Phys_Addr, Size, Pgprot);
   end;

   procedure Queue_Delayed_Work_On_C (Cpu    : Ic.Int; 
                                      Wq     : Wq_Struct_Access; 
                                      Work   : Delayed_Work_Access;
                                      Delayy : Ic.Unsigned_Long) with
      Import        => True,
      Convention    => C,
      External_Name => "queue_delayed_work_on";

   procedure Queue_Delayed_Work (Wq     : Wq_Struct_Access; 
                                 Work   : Delayed_Work_Access;
                                 Delayy : Ic.Unsigned_Long) is
   begin
      Queue_Delayed_Work_On_C (1, Wq, Work, Delayy);
   end;

   function Alloc_Workqueue_Key_C (Format         : String; 
                                   Flags          : Ic.Unsigned; 
                                   Max_Active     : Ic.Int;
                                   Lock_Class_Key : Lock_Class_Key_Access; 
                                   Lock_Name      : String;
                                   Name           : String) return Wq_Struct_Access with
      Import        => True,
      Convention    => C,
      External_Name => "__alloc_workqueue_key";

   function Create_Singlethread_Wq (Name : String) Return Wq_Struct_Access Is
      type Workqueue_Flags is record
         WQ_UNBOUND          : Bool;
         WQ_FREEZABLE        : Bool;
         WQ_MEM_RECLAIM      : Bool;
         WQ_HIGHPRI          : Bool;
         WQ_CPU_INTENSIVE    : Bool;
         WQ_SYSFS            : Bool;
         WQ_POWER_EFFICIENT  : Bool;
         WQ_DRAINING         : Bool;
         WQ_ORDERED          : Bool;
         WQ_LEGACY           : Bool;
         WQ_ORDERED_EXPLICIT : Bool;
      end record
         with Size => System.Word_Size;
      --for Workqueue_Flags'size use System.Word_Size;
      for Workqueue_Flags use record
         WQ_UNBOUND          at 0 range  1 ..  1;
         WQ_FREEZABLE        at 0 range  2 ..  2;
         WQ_MEM_RECLAIM      at 0 range  3 ..  3;
         WQ_HIGHPRI          at 0 range  4 ..  4;
         WQ_CPU_INTENSIVE    at 0 range  5 ..  5;
         WQ_SYSFS            at 0 range  6 ..  6;
         WQ_POWER_EFFICIENT  at 0 range  7 ..  7;
         WQ_DRAINING         at 0 range 16 .. 16;
         WQ_ORDERED          at 0 range 17 .. 17;
         WQ_LEGACY           at 0 range 18 .. 18;
         WQ_ORDERED_EXPLICIT at 0 range 19 .. 19;
      end record;
      Flags : Workqueue_Flags := (WQ_UNBOUND          => YES,
                                  WQ_ORDERED          => YES,
                                  WQ_ORDERED_EXPLICIT => YES,
                                  WQ_LEGACY           => YES,
                                  WQ_MEM_RECLAIM      => YES,
                                  Others              => NO);
      Wq_Flags : Ic.Unsigned with Address => Flags'address;
      --for Wq_Flags'address use Flags'address;
   begin
      return Alloc_Workqueue_Key_C ("%s",
                                    Wq_Flags,
                                    1,
                                    Null_Lock,
                                    "",
                                    Name);
   end;

   procedure Delayed_Work_Timer_Fn_C (Data : Ic.Unsigned_Long) with
      Import        => True,
      Convention    => C,
      External_Name => "delayed_work_timer_fn";

   procedure Delayed_Work_Timer_Fn (Data : Ic.Unsigned_Long) is
   begin
      Delayed_Work_Timer_Fn_C (Data);
   end Delayed_Work_Timer_Fn;

   procedure Cancel_Delayed_Work_C (Delayed_Work : Delayed_Work_Access) with
      Import        => True,
      Convention    => C,
      External_Name => "cancel_delayed_work";

   procedure Cancel_Delayed_Work (Delayed_Work : Delayed_Work_Access) is
   begin
      Cancel_Delayed_Work_C (Delayed_Work);
   end;

   procedure Flush_Workqueue_C (Wq : Wq_Struct_Access) with
      Import        => True,
      Convention    => C,
      External_Name => "flush_workqueue";

   procedure Flush_Workqueue (Wq : Wq_Struct_Access) is
   begin
      Flush_Workqueue_C (Wq);
   end;

   procedure Destroy_Workqueue_C (Wq : Wq_Struct_Access) with
      Import        => True,
      Convention    => C,
      External_Name => "destroy_workqueue";

   procedure Destroy_Workqueue (Wq : Wq_Struct_Access) is
   begin
      Destroy_Workqueue_C (Wq);
   end;

   procedure Io_Write_32 (Val : U32; Addr : Iomem_Access) is
      use System.Machine_Code;
   begin
      Asm (Template => "dsb st", 
           Clobber  => "memory", 
           Volatile => True);

      Asm (Template => "str %w0, [%1]",
           Inputs   => (U32'Asm_Input ("rZ", Val), Iomem_Access'Asm_Input ("r", Addr)),
           Volatile => True);
   end;

   function Io_Read_32 (Addr : Iomem_Access) return U32 is
      use System.Machine_Code;
      Value : U32;
   begin
      Asm (Template => "ldr %w0, [%1]",
           Inputs   => (Iomem_Access'Asm_Input ("r", Addr)),
           Outputs  => (Kernel.U32'Asm_Output ("=r", Value)), 
           Volatile => True);
      return Value;
   end;

end Kernel;
