With Ada.Unchecked_Conversion;
With System.Machine_Code;
Package Body Kernel Is

   Procedure Printk_C (S : String) With
     Import        => True,
     Convention    => C,
     External_Name => "printk";

   Procedure Printk (S : String) Is
   Begin
      Printk_C (S & Ascii.Lf & Ascii.Nul);
   End Printk;

   Procedure Print_Access_Hex_C (A : System.Address) With
     Import        => True,
     Convention    => C,
     External_Name => "print_access_hex";

   Procedure Printk (A : System.Address) Is
   Begin
      Print_Access_Hex_C (A);
   End;

   Procedure Print_Access_Hex_C (A : System.Storage_Elements.Integer_Address) With
     Import        => True,
     Convention    => C,
     External_Name => "print_access_hex";

   Procedure Printk (A : System.Storage_Elements.Integer_Address) Is
   Begin
      Print_Access_Hex_C (A);
   End;

   -- Gpio

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
   End Gpio_Request;

   Function Gpio_Direction_Output
     (Gpio : Ic.Unsigned; Value : Ic.Int) Return Ic.Int
   Is
      Desc : Gpio_Desc_Acc := Gpio_To_Desc_C (Gpio);
   Begin
      Return Gpiod_Direction_Output_Raw_C (Desc, Value);
   End Gpio_Direction_Output;

   Function Gpio_Get_Value (Gpio : Ic.Unsigned) Return Ic.Int Is
      Desc : Gpio_Desc_Acc := Gpio_To_Desc_C (Gpio);
   Begin
      Return Gpiod_Get_Raw_Value_C (Desc);
   End Gpio_Get_Value;

   Procedure Gpio_Free_C (Gpio : Ic.Unsigned) With
     Import        => True,
     Convention    => C,
     External_Name => "gpio_free";

   Procedure Gpio_Free (Gpio : Ic.Unsigned) Is
   Begin
      Gpio_Free_C (Gpio);
   End Gpio_Free;

   Function Msecs_To_Jiffies_C (M : Ic.Unsigned) Return Ic.Unsigned_Long With
     Import        => True,
     Convention    => C,
     External_Name => "__msecs_to_jiffies";

   Function Msecs_To_Jiffies (M : Ic.Unsigned) Return Ic.Unsigned_Long Is
   Begin
      Return Msecs_To_Jiffies_C (M);
   End Msecs_To_Jiffies;

   Type Pgprot_T Is Mod 2**64;
   For Pgprot_T'Size Use 64;
   Function Ioremap_C (Phys_Addr : Phys_Addr_T; Size : Ic.Size_T; Pgprot : Pgprot_T) Return Iomem_Access With
     Import        => True,
     Convention    => C,
     External_Name => "__ioremap";

   --Type Bool Is (F, T);
   --For Bool Use (False => 0, True => 1);
   --For Bool'Size Use 1;

   --Function Ioremap (Phys_Addr : Phys_Addr_T; Size : Ic.Size_T) Return Iomem_Access Is
   --    Type PTE_Flags Is Record
   --
   --    End Record;
   --Begin
   --End;
   --Ioremap_C (Phys_Addr, )

   --Type Bool Is (False, True);
   --For Bool Use (False => 0, True => 1);

   --For Bool'Size Use 1;

   Function Ioremap
     (Phys_Addr : Phys_Addr_T; Size : Ic.Size_T) Return Iomem_Access
   Is

      -- Arm64/Include/Asm/Pgtable-Prot.H
      -- #define PROT_DEVICE_NGnRE (PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_DIRTY | PTE_WRITE | PTE_ATTRINDX(MT_DEVICE_NGnRE))
      -- #define PROT_DEFAULT              (_PROT_DEFAULT | PTE_MAYBE_NG)
      -- #define PTE_MAYBE_NG              (Arm64_Kernel_Unmapped_At_El0() ? PTE_NG : 0)
      -- #define _PROT_DEFAULT             (PTE_TYPE_PAGE | PTE_AF | PTE_SHARED)

      -- Arm64/Include/Asm/Pgtable-Hwdef.H
      -- /*
      -- * Level 3 Descriptor (PTE).
      -- */
      -- #define PTE_TYPE_MASK             (_AT(Pteval_T, 3) << 0)
      -- #define PTE_TYPE_FAULT            (_AT(Pteval_T, 0) << 0)
      -- #define PTE_TYPE_PAGE             (_AT(Pteval_T, 3) << 0)
      -- #define PTE_TABLE_BIT             (_AT(Pteval_T, 1) << 1)
      -- #define PTE_USER                  (_AT(Pteval_T, 1) << 6)         /* AP[1] */
      -- #define PTE_RDONLY                (_AT(Pteval_T, 1) << 7)         /* AP[2] */
      -- #define PTE_SHARED                (_AT(Pteval_T, 3) << 8)         /* SH[1:0], Inner Shareable */
      -- #define PTE_AF                    (_AT(Pteval_T, 1) << 10)        /* Access Flag */
      -- #define PTE_NG                    (_AT(Pteval_T, 1) << 11)        /* NG */
      -- #define PTE_DBM                   (_AT(Pteval_T, 1) << 51)        /* Dirty Bit Management */
      -- #define PTE_CONT                  (_AT(Pteval_T, 1) << 52)        /* Contiguous Range */
      -- #define PTE_PXN                   (_AT(Pteval_T, 1) << 53)        /* Privileged XN */
      -- #define PTE_UXN                   (_AT(Pteval_T, 1) << 54)        /* User XN */
      -- #define PTE_HYP_XN                (_AT(Pteval_T, 1) << 54)        /* HYP XN */

      -- Arm64/Include/Asm/Pgtable-Prot.H
      -- /*
      -- * Software Defined PTE Bits Definition.
      -- */
      -- #define PTE_VALID             (_AT(Pteval_T, 1) << 0)
      -- #define PTE_WRITE             (PTE_DBM)            /* Same As DBM (51) */
      -- #define PTE_DIRTY             (_AT(Pteval_T, 1) << 55)
      -- #define PTE_SPECIAL               (_AT(Pteval_T, 1) << 56)
      -- #define PTE_PROT_NONE             (_AT(Pteval_T, 1) << 58) /* Only When !PTE_VALID */

      -- Arm64/Include/Asm/Pgtable-Hwdef.H
      -- /*
      -- * AttrIndx[2:0] Encoding (Mapping Attributes Defined In The MAIR* Registers).
      -- */
      -- #define PTE_ATTRINDX(T)   (_AT(Pteval_T, (T)) << 2)
      -- #define PTE_ATTRINDX_MASK (_AT(Pteval_T, 7) << 2)
      --

      --/*
      -- * Memory Types Available.
      -- */
      -- Arm64/Include/Asm/Memory.H
      -- #define MT_DEVICE_NGnRnE  0
      -- #define MT_DEVICE_NGnRE   1
      -- #define MT_DEVICE_GRE             2
      -- #define MT_NORMAL_NC              3
      -- #define MT_NORMAL             4
      -- #define MT_NORMAL_WT              5

      --__Ioremap((Phys_Addr + Offset), (4), ((Pgprot_T) {
      --(((((((Pteval_T)(3)) << 0) | -- PTE_TYPE_MASK
      --(((Pteval_T)(1)) << 10) | -- PTE_AF
      --(((Pteval_T)(3)) << 8)) | -- PTE_SHARED
      --(Arm64_Kernel_Unmapped_At_El0() ? (((Pteval_T)(1)) << 11) : 0)) | -- If Arm64_Kernel_Unmapped_At_El0() Then PTE_NG Else 0
      --(((Pteval_T)(1)) << 53) | -- PTE_PXN
      --(((Pteval_T)(1)) << 54) | -- PTE_UXN

      --(((Pteval_T)(1)) << 55) | -- PTE_DIRTY
      --((((Pteval_T)(1)) << 51)) | -- PTE_DBM

      --(((Pteval_T)((1))) << 2))) } )); -- PTE_ATTRINDX(MT_DEVICE_NGnRE)

      Pgprot : Pgprot_T := 16#00e8_0000_0000_0707#;
   Begin
      Return Ioremap_C (Phys_Addr, Size, Pgprot);
   End Ioremap;

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
   End Queue_Delayed_Work;

   Function Alloc_Workqueue_Key_C
     (Format         : String; Flags : Ic.Unsigned; Max_Active : Ic.Int;
      Lock_Class_Key : System.Address; Lock_Name : System.Address;
      Name           : String) Return Workqueue_Struct_Access With
     Import        => True,
     Convention    => C,
     External_Name => "__alloc_workqueue_key";

   Function Alloc_Workqueue (Name : String) Return Workqueue_Struct_Access Is
      Type Bit Is Mod 2**1;
      Type Workqueue_Flags Is Record
         WQ_UNBOUND          : Bit;
         WQ_FREEZABLE        : Bit;
         WQ_MEM_RECLAIM      : Bit;
         WQ_HIGHPRI          : Bit;
         WQ_CPU_INTENSIVE    : Bit;
         WQ_SYSFS            : Bit;
         WQ_POWER_EFFICIENT  : Bit;
         WQ_DRAINING         : Bit;
         WQ_ORDERED          : Bit;
         WQ_LEGACY           : Bit;
         WQ_ORDERED_EXPLICIT : Bit;
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
        (WQ_UNBOUND => 1, WQ_ORDERED => 1, WQ_ORDERED_EXPLICIT => 1,
         WQ_LEGACY  => 1, WQ_MEM_RECLAIM => 1, Others => 0);
      Wq_Flags : Ic.Unsigned;
      For Wq_Flags'Address Use Flags'Address;
   Begin
      Return
        Alloc_Workqueue_Key_C
          ("%s", Wq_Flags, 1, System.Null_Address, System.Null_Address,
           Name);
   End Alloc_Workqueue;

   Procedure Delayed_Work_Timer_Fn_C (Data : Ic.Unsigned_Long) With
     Import        => True,
     Convention    => C,
     External_Name => "delayed_work_timer_fn";

   Procedure Delayed_Work_Timer_Fn (Data : Ic.Unsigned_Long) Is
   Begin
      Delayed_Work_Timer_Fn_C (Data);
   End Delayed_Work_Timer_Fn;

   Procedure Cancel_Delayed_Work_C (Delayed_Work : Delayed_Work_Access) With
     Import        => True,
     Convention    => C,
     External_Name => "cancel_delayed_work";

   Procedure Cancel_Delayed_Work (Delayed_Work : Delayed_Work_Access) Is
   Begin
      Cancel_Delayed_Work_C (Delayed_Work);
   End Cancel_Delayed_Work;

   Procedure Flush_Workqueue_C (Wq : Workqueue_Struct_Access) With
     Import        => True,
     Convention    => C,
     External_Name => "flush_workqueue";

   Procedure Flush_Workqueue (Wq : Workqueue_Struct_Access) Is
   Begin
      Flush_Workqueue_C (Wq);
   End Flush_Workqueue;

   Procedure Destroy_Workqueue_C (Wq : Workqueue_Struct_Access) With
     Import        => True,
     Convention    => C,
     External_Name => "destroy_workqueue";

   Procedure Destroy_Workqueue (Wq : Workqueue_Struct_Access) Is
   Begin
      Destroy_Workqueue_C (Wq);
   End Destroy_Workqueue;

   Procedure Io_Write_32 (Val : U32; Addr : Iomem_Access) Is
      Use System.Machine_Code;
   Begin
      Asm (Template => "dsb st", Clobber => "memory", Volatile => True);

      Asm (Template => "str %w0, [%1]",
           Inputs    =>
             (U32'Asm_Input ("rZ", Val),
              Iomem_Access'Asm_Input ("r", Addr)),
           Volatile => True);
   End Io_Write_32;

   Function Io_Read_32 (Addr : Iomem_Access) Return U32 Is
      Use System.Machine_Code;
      Value : U32;
   Begin
      Asm (Template => "ldr %w0, [%1]",
           Inputs    => (Iomem_Access'Asm_Input ("r", Addr)),
           Outputs   => (Kernel.U32'Asm_Output ("=r", Value)),
           Volatile  => True);

      Return Value;
   End Io_Read_32;

End Kernel;
