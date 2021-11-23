pragma Warnings (Off);
pragma Ada_95;
pragma Restrictions (No_Exception_Propagation);
with System;
with System.Parameters;
with System.Secondary_Stack;
package ada_linuxmain is

   procedure ada_linuxinit;
   pragma Export (C, ada_linuxinit, "ada_linuxinit");
   pragma Linker_Constructor (ada_linuxinit);

   type Version_32 is mod 2 ** 32;
   u00001 : constant Version_32 := 16#e958b56d#;
   pragma Export (C, u00001, "ada_linuxB");
   u00002 : constant Version_32 := 16#a0519e26#;
   pragma Export (C, u00002, "ada_linuxS");
   u00003 : constant Version_32 := 16#12b9b91a#;
   pragma Export (C, u00003, "linuxB");
   u00004 : constant Version_32 := 16#1fe8c001#;
   pragma Export (C, u00004, "linuxS");

   --  BEGIN ELABORATION ORDER
   --  ada%s
   --  interfaces%s
   --  system%s
   --  ada.exceptions%s
   --  ada.exceptions%b
   --  system.parameters%s
   --  system.storage_elements%s
   --  system.storage_elements%b
   --  system.secondary_stack%s
   --  system.secondary_stack%b
   --  interfaces.c%s
   --  interfaces.c%b
   --  linux%s
   --  linux%b
   --  ada_linux%s
   --  ada_linux%b
   --  END ELABORATION ORDER

end ada_linuxmain;
