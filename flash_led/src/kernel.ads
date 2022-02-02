with Interfaces.C;
with System;
with System.Storage_Elements;

package Kernel is

   type U32 is mod 2**32;
   for U32'Size use 32;

   package Ic renames Interfaces.C;

   -- Debug
   procedure Printk (S : String);
   procedure Printk (A : System.Address);

   -- Gpio
   function Gpio_Request (Gpio : Ic.unsigned; Label : String) return Ic.int;
   function Gpio_Direction_Output (Gpio : Ic.unsigned; Value : Ic.int) return Ic.int;
   function Gpio_Get_Value (Gpio : Ic.unsigned) return Ic.int;
   procedure Gpio_Free (Gpio : Ic.unsigned);

   function Msecs_To_Jiffies (M : Ic.unsigned) return Ic.unsigned_long;

   type Hlist_Node;
   type Hlist_Node_Acc is access Hlist_Node;

   type Hlist_Node is record
      Next  : Hlist_Node_Acc;
      Pprev : Hlist_Node_Acc;
   end record with
      Convention => C;

   type Timer_List_Function_T is access procedure (Data : Ic.unsigned_long) with
      Convention => C;

   type Timer_List is record
      Entryy  : Hlist_Node;
      Expires : Ic.unsigned_long;
      Func    : Timer_List_Function_T;
      Data    : Ic.unsigned_long;
      Flags   : U32;
   end record with
      Convention => C;

   type Phys_Addr_T is new System.Address;
   type Iomem_Access is new System.Address;
   function Ioremap (Phys_Addr : Phys_Addr_T; Size : Ic.size_t) return Iomem_Access;

   type List_Head;
   type List_Head_Access is access all List_Head;

   type List_Head is record
      Prev : List_Head_Access;
      Next : List_Head_Access;
   end record with
      Convention => C;

   type Work_Struct;
   type Work_Struct_Access is access all Work_Struct;
   type Work_Func_T is access procedure (Work : Work_Struct_Access);

   type Atomic_Long_T is new Ic.unsigned_long;
   type Work_Struct is record
      Data   : Atomic_Long_T;
      Entryy : aliased List_Head;
      Func   : Work_Func_T;
   end record with
      Convention => C;

   type Workqueue_Struct_Access is new System.Address;
   type Lock_Class_Key_Access is new System.Address;
   Null_Wq : Workqueue_Struct_Access := Workqueue_Struct_Access (System.Null_Address);
   Null_Lock : Lock_Class_Key_Access := Lock_Class_Key_Access (System.Null_Address);

   type Delayed_Work is record
      Work  : Work_Struct;
      Timer : Timer_List;
      Wq    : Workqueue_Struct_Access;
      Cpu   : Ic.int;
   end record;
   type Delayed_Work_Access is access all Delayed_Work;

   procedure Queue_Delayed_Work (Wq     : Workqueue_Struct_Access;
                                 Work   : Delayed_Work_Access;
                                 Delayy : Ic.unsigned_long);

   function Create_Singlethread_Wq (Name : String) return Workqueue_Struct_Access;

   -- function Create_Singlethread_Wq (Name : String) return Workqueue_Struct_Access with
   --    Import        => True,
   --    Convention    => C,
   --    External_Name => "wrapper_create_singlethread_wq";

   procedure Delayed_Work_Timer_Fn (Data : Ic.unsigned_long) with
      Convention => C;

   procedure Cancel_Delayed_Work (Delayed_Work : Delayed_Work_Access);
   procedure Flush_Workqueue (Wq : Workqueue_Struct_Access);
   procedure Destroy_Workqueue (Wq : Workqueue_Struct_Access);

   procedure Io_Write_32 (Val : U32; Addr : Iomem_Access);
   function Io_Read_32 (Addr : Iomem_Access) return U32;

end Kernel;
