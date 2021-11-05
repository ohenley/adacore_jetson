pragma Warnings (Off);
pragma Ada_95;
pragma Source_File_Name (ada_linuxmain, Spec_File_Name => "b__ada_linux.ads");
pragma Source_File_Name (ada_linuxmain, Body_File_Name => "b__ada_linux.adb");
pragma Suppress (Overflow_Check);

package body ada_linuxmain is

   E02 : Short_Integer; pragma Import (Ada, E02, "ada_linux_E");

   Sec_Default_Sized_Stacks : array (1 .. 1) of aliased System.Secondary_Stack.SS_Stack (System.Parameters.Runtime_Default_Sec_Stack_Size);


   procedure ada_linuxinit is
      Binder_Sec_Stacks_Count : Natural;
      pragma Import (Ada, Binder_Sec_Stacks_Count, "__gnat_binder_ss_count");

      Default_Secondary_Stack_Size : System.Parameters.Size_Type;
      pragma Import (C, Default_Secondary_Stack_Size, "__gnat_default_ss_size");
      Default_Sized_SS_Pool : System.Address;
      pragma Import (Ada, Default_Sized_SS_Pool, "__gnat_default_ss_pool");

   begin
      null;

      ada_linuxmain'Elab_Body;
      Default_Secondary_Stack_Size := System.Parameters.Runtime_Default_Sec_Stack_Size;
      Binder_Sec_Stacks_Count := 1;
      Default_Sized_SS_Pool := Sec_Default_Sized_Stacks'Address;


      E02 := E02 + 1;
   end ada_linuxinit;

--  BEGIN Object file/option list
   --   /home/henley/adacore/repos/adacore_jetson/hello/obj/gpio_h.o
   --   /home/henley/adacore/repos/adacore_jetson/hello/obj/linux.o
   --   /home/henley/adacore/repos/adacore_jetson/hello/obj/printk_h.o
   --   /home/henley/adacore/repos/adacore_jetson/hello/obj/ada_linux.o
   --   -L/home/henley/adacore/repos/adacore_jetson/hello/obj/
   --   -L/home/henley/adacore/repos/adacore_jetson/rts-native-light/adalib/
--  END Object file/option list   

end ada_linuxmain;
