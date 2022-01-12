With Ada.Unchecked_Conversion;
With System.Machine_Code;
Package Body Kernel Is

   Type Bool Is (NO, YES);
   For Bool Use (NO => 0, YES => 1);
   For Bool'Size Use 1;

   Procedure Printk_C (S : String) With
     Import        => True,
     Convention    => C,
     External_Name => "printk";

   Procedure Printk (S : String) Is
   Begin
      Printk_C (S & Ascii.Lf & Ascii.Nul);
   End;

   Procedure Print_Access_Hex_C (A : System.Address) With
     Import        => True,
     Convention    => C,
     External_Name => "print_access_hex";

   Procedure Printk (A : System.Address) Is
   Begin
      Print_Access_Hex_C (A);
   End;

   Type Gpio_Desc_Acc Is New System.Address;

   Function Gpio_To_Desc_C (Gpio : Ic.Unsigned) Return Gpio_Desc_Acc With
     Import        => True,
     Convention    => C,
     External_Name => "gpio_to_desc";

   Function Gpiod_Direction_Output_Raw_C
     (Desc : Gpio_Desc_Acc; Value : Ic.Int) Return Ic.Int With
     Import        => True,
     Convention    => C,
     External_Name => "gpiod_direction_output_raw";

   Function Gpiod_Get_Raw_Value_C (Desc : Gpio_Desc_Acc) Return Ic.Int With
     Import        => True,
     Convention    => C,
     External_Name => "gpiod_get_raw_value";

   Function Gpio_Request_C
     (Gpio : Ic.Unsigned; Label : String) Return Ic.Int With
     Import        => True,
     Convention    => C,
     External_Name => "gpio_request";

   Function Gpio_Request (Gpio : Ic.Unsigned; Label : String) Return Ic.Int Is
   Begin
      Return Gpio_Request_C (Gpio, Label & Ascii.Lf & Ascii.Nul);
   End;

   Function Gpio_Direction_Output
     (Gpio : Ic.Unsigned; Value : Ic.Int) Return Ic.Int
   Is
      Desc : Gpio_Desc_Acc := Gpio_To_Desc_C (Gpio);
   Begin
      Return Gpiod_Direction_Output_Raw_C (Desc, Value);
   End;

   Function Gpio_Get_Value (Gpio : Ic.Unsigned) Return Ic.Int Is
      Desc : Gpio_Desc_Acc := Gpio_To_Desc_C (Gpio);
   Begin
      Return Gpiod_Get_Raw_Value_C (Desc);
   End;

   Procedure Gpio_Free_C (Gpio : Ic.Unsigned) With
     Import        => True,
     Convention    => C,
     External_Name => "gpio_free";

   Procedure Gpio_Free (Gpio : Ic.Unsigned) Is
   Begin
      Gpio_Free_C (Gpio);
   End;

   Function Msecs_To_Jiffies_C (M : Ic.Unsigned) Return Ic.Unsigned_Long With
     Import        => True,
     Convention    => C,
     External_Name => "__msecs_to_jiffies";

   Function Msecs_To_Jiffies (M : Ic.Unsigned) Return Ic.Unsigned_Long Is
   Begin
      Return Msecs_To_Jiffies_C (M);
   End;

   Type Pgprot_T Is Mod 2**64;
   For Pgprot_T'Size Use 64;
   Function Ioremap_C (Phys_Addr : Phys_Addr_T; Size : Ic.Size_T; Pgprot : Pgprot_T) Return Iomem_Access With
     Import        => True,
     Convention    => C,
     External_Name => "__ioremap";

   Function Ioremap (Phys_Addr : Phys_Addr_T; Size : Ic.Size_T) Return Iomem_Access Is
        Type Memory_T Is Range 0 .. 5;

        MT_DEVICE_NGnRnE : Memory_T := 0;
        MT_DEVICE_NGnRE  : Memory_T := 1;
        MT_DEVICE_GRE    : Memory_T := 2;
        MT_NORMAL_NC     : Memory_T := 3;
        MT_NORMAL        : Memory_T := 4;
        MT_NORMAL_WT     : Memory_T := 5;

        Function PTE_ATTRINDX (Mt : Memory_T) Return Pgprot_T Is
        Begin
            Return Pgprot_T(Mt * 2#1#e+2);
        End;

        -- Page Table Entry
        PTE_VALID      : Pgprot_T := 2#1#e+0;
        PTE_WRITE      : Pgprot_T := 2#1#e+51;
        PTE_DIRTY      : Pgprot_T := 2#1#e+55;
        PTE_SPECIAL    : Pgprot_T := 2#1#e+56;
        PTE_PROT_NONE  : Pgprot_T := 2#1#e+58;
        PTE_TYPE_MASK  : Pgprot_T := 3 * 2#1#e+0;
        PTE_TYPE_FAULT : Pgprot_T := 2#0#e+0;
        PTE_TYPE_PAGE  : Pgprot_T := 3 * 2#1#e+0;
        PTE_TABLE_BIT  : Pgprot_T := 2#1#e+1;
        PTE_USER       : Pgprot_T := 2#1#e+6;
        PTE_RDONLY     : Pgprot_T := 2#1#e+7;
        PTE_SHARED     : Pgprot_T := 3 * 2#1#e+8;  -- Inner Shareable
        PTE_AF         : Pgprot_T := 2#1#e+10;     -- Access Flag
        PTE_NG         : Pgprot_T := 2#1#e+11;     -- NG
        PTE_DBM        : Pgprot_T := 2#1#e+51;     -- Dirty Bit Management
        PTE_CONT       : Pgprot_T := 2#1#e+52;     -- Contiguous Range
        PTE_PXN        : Pgprot_T := 2#1#e+53;     -- Privileged XN
        PTE_UXN        : Pgprot_T := 2#1#e+54;     -- User XN
        PTE_HYP_XN     : Pgprot_T := 2#1#e+54;     -- HYP XN

        Pgprot : Pgprot_T := (PTE_TYPE_MASK Or 
                              PTE_AF Or
                              PTE_SHARED Or
                              PTE_PXN Or
                              PTE_UXN Or
                              PTE_DIRTY Or
                              PTE_DBM Or
                              PTE_ATTRINDX (MT_DEVICE_NGnRE));
   Begin
      Return Ioremap_C (Phys_Addr, Size, Pgprot);
   End;

   Procedure Queue_Delayed_Work_On_C
     (Cpu    : Ic.Int; Wq : Workqueue_Struct_Access; Work : Delayed_Work_Access;
      Delayy : Ic.Unsigned_Long) With
     Import        => True,
     Convention    => C,
     External_Name => "queue_delayed_work_on";

   Procedure Queue_Delayed_Work
     (Wq     : Workqueue_Struct_Access; Work : Delayed_Work_Access;
      Delayy : Ic.Unsigned_Long)
   Is
   Begin
      Queue_Delayed_Work_On_C (1, Wq, Work, Delayy);
   End;

   Function Alloc_Workqueue_Key_C
     (Format         : String; Flags : Ic.Unsigned; Max_Active : Ic.Int;
      Lock_Class_Key : System.Address; Lock_Name : System.Address;
      Name           : String) Return Workqueue_Struct_Access With
     Import        => True,
     Convention    => C,
     External_Name => "__alloc_workqueue_key";

   Function Alloc_Workqueue (Name : String) Return Workqueue_Struct_Access Is
      Type Workqueue_Flags Is Record
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
      End Record;
      For Workqueue_Flags'Size Use 32;
      For Workqueue_Flags Use Record
         WQ_UNBOUND          At 0 Range  1 ..  1;
         WQ_FREEZABLE        At 0 Range  2 ..  2;
         WQ_MEM_RECLAIM      At 0 Range  3 ..  3;
         WQ_HIGHPRI          At 0 Range  4 ..  4;
         WQ_CPU_INTENSIVE    At 0 Range  5 ..  5;
         WQ_SYSFS            At 0 Range  6 ..  6;
         WQ_POWER_EFFICIENT  At 0 Range  7 ..  7;
         WQ_DRAINING         At 0 Range 16 .. 16;
         WQ_ORDERED          At 0 Range 17 .. 17;
         WQ_LEGACY           At 0 Range 18 .. 18;
         WQ_ORDERED_EXPLICIT At 0 Range 19 .. 19;
      End Record;
      Flags : Workqueue_Flags :=
        (WQ_UNBOUND => YES, 
         WQ_ORDERED => YES, 
         WQ_ORDERED_EXPLICIT => YES,
         WQ_LEGACY  => YES, 
         WQ_MEM_RECLAIM => YES, 
         Others => NO);
      Wq_Flags : Ic.Unsigned;
      For Wq_Flags'Address Use Flags'Address;
   Begin
      Return
        Alloc_Workqueue_Key_C
          ("%s", Wq_Flags, 1, System.Null_Address, System.Null_Address,
           Name);
   End;

   Procedure Delayed_Work_Timer_Fn_C (Data : Ic.Unsigned_Long) With
     Import        => True,
     Convention    => C,
     External_Name => "delayed_work_timer_fn";

   Procedure Delayed_Work_Timer_Fn (Data : Ic.Unsigned_Long) Is
   Begin
      Delayed_Work_Timer_Fn_C (Data);
   End;

   Procedure Cancel_Delayed_Work_C (Delayed_Work : Delayed_Work_Access) With
     Import        => True,
     Convention    => C,
     External_Name => "cancel_delayed_work";

   Procedure Cancel_Delayed_Work (Delayed_Work : Delayed_Work_Access) Is
   Begin
      Cancel_Delayed_Work_C (Delayed_Work);
   End;

   Procedure Flush_Workqueue_C (Wq : Workqueue_Struct_Access) With
     Import        => True,
     Convention    => C,
     External_Name => "flush_workqueue";

   Procedure Flush_Workqueue (Wq : Workqueue_Struct_Access) Is
   Begin
      Flush_Workqueue_C (Wq);
   End;

   Procedure Destroy_Workqueue_C (Wq : Workqueue_Struct_Access) With
     Import        => True,
     Convention    => C,
     External_Name => "destroy_workqueue";

   Procedure Destroy_Workqueue (Wq : Workqueue_Struct_Access) Is
   Begin
      Destroy_Workqueue_C (Wq);
   End;

   Procedure Io_Write_32 (Val : U32; Addr : Iomem_Access) Is
      Use System.Machine_Code;
   Begin
      Asm (Template => "dsb st", Clobber => "memory", Volatile => True);

      Asm (Template => "str %w0, [%1]",
           Inputs    => (U32'Asm_Input ("rZ", Val), Iomem_Access'Asm_Input ("r", Addr)),
           Volatile => True);
   End;

   Function Io_Read_32 (Addr : Iomem_Access) Return U32 Is
      Use System.Machine_Code;
      Value : U32;
   Begin
      Asm (Template => "ldr %w0, [%1]",
           Inputs    => (Iomem_Access'Asm_Input ("r", Addr)),
           Outputs   => (Kernel.U32'Asm_Output ("=r", Value)),
           Volatile  => True);
      Return Value;
   End;

End Kernel;
