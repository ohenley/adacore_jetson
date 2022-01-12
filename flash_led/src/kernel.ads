With Interfaces.C;
With System;
With System.Storage_Elements;

Package Kernel Is

   Type U32 Is Mod 2**32;
   For U32'Size Use 32;

   Package Ic Renames Interfaces.C;
    
   -- Debug
   Procedure Printk (S : String);
   Procedure Printk (A : System.Address);

   -- Gpio
   Function Gpio_Request (Gpio : Ic.Unsigned; Label : String) Return Ic.Int;
   Function Gpio_Direction_Output (Gpio : Ic.Unsigned; Value : Ic.Int) Return Ic.Int;
   Function Gpio_Get_Value (Gpio : Ic.Unsigned) Return Ic.Int;
   Procedure Gpio_Free (Gpio : Ic.Unsigned);

   Function Msecs_To_Jiffies (M : Ic.Unsigned) Return Ic.Unsigned_Long;
    
   Type Hlist_Node;
   Type Hlist_Node_Acc Is Access Hlist_Node;

   Type Hlist_Node Is Record
      Next  : Hlist_Node_Acc;
      Pprev : Hlist_Node_Acc;
   End Record With
      Convention => C;

   Type Timer_List_Function_T Is Access Procedure (Data : Ic.Unsigned_Long) With
     Convention => C;

   Type Timer_List Is Record
      Entryy     : Hlist_Node;
      Expires    : Ic.Unsigned_Long;
      Func       : Timer_List_Function_T;
      Data       : Ic.Unsigned_Long;
      Flags      : U32;
   End Record With
     Convention => C;

   Type Phys_Addr_T Is New System.Address;
   Type Iomem_Access Is New System.Address;
   Function Ioremap (Phys_Addr : Phys_Addr_T; Size : Ic.Size_T) Return Iomem_Access;

   Type List_Head;
   Type List_Head_Access Is Access All List_Head;

   Type List_Head Is Record
      Prev : List_Head_Access;
      Next : List_Head_Access;
   End Record With
     Convention => C;
 
   Type Work_Struct;
   Type Work_Struct_Access Is Access All Work_Struct;

   Type Work_Func_T Is Access Procedure (Work : Work_Struct_Access) With
     Convention => C;

   Type Atomic_Long_T Is New Ic.Unsigned_Long;
   Type Work_Struct Is Record
      Data   : Atomic_Long_T;
      Entryy : Aliased List_Head;
      Func   : Work_Func_T;
   End Record With
     Convention => C;

   Type Workqueue_Struct_Access Is New System.Address;
   Null_Wq : Kernel.Workqueue_Struct_Access := Kernel.Workqueue_Struct_Access (System.Null_Address);

   Type Delayed_Work Is Record
      Work  : Work_Struct;
      Timer : Timer_List;
      Wq    : Workqueue_Struct_Access;
      Cpu   : Ic.Int;
   End Record;
   Type Delayed_Work_Access Is Access All Delayed_Work;

   Procedure Queue_Delayed_Work (Wq     : Workqueue_Struct_Access;
                                 Work   : Delayed_Work_Access;
                                 Delayy : Ic.Unsigned_Long);
    
   Function Alloc_Workqueue (Name : String) Return Workqueue_Struct_Access;

   Procedure Delayed_Work_Timer_Fn (Data : Ic.Unsigned_Long) With Convention => C;

   Procedure Cancel_Delayed_Work (Delayed_Work : Delayed_Work_Access);
   Procedure Flush_Workqueue (Wq : Workqueue_Struct_Access);
   Procedure Destroy_Workqueue (Wq : Workqueue_Struct_Access);

   Procedure Io_Write_32 (Val : U32; Addr : Iomem_Access);
   Function Io_Read_32 (Addr : Iomem_Access) Return U32;

End Kernel;
