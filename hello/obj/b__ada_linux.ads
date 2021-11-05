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
   u00001 : constant Version_32 := 16#44032dd4#;
   pragma Export (C, u00001, "ada_linuxB");
   u00002 : constant Version_32 := 16#3f164c44#;
   pragma Export (C, u00002, "ada_linuxS");
   u00003 : constant Version_32 := 16#3018fe90#;
   pragma Export (C, u00003, "gpio_hS");
   u00004 : constant Version_32 := 16#7e509733#;
   pragma Export (C, u00004, "linuxS");
   u00005 : constant Version_32 := 16#f8d57d04#;
   pragma Export (C, u00005, "printk_hS");

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
   --  interfaces.c.strings%s
   --  interfaces.c.strings%b
   --  gpio_h%s
   --  linux%s
   --  printk_h%s
   --  ada_linux%s
   --  ada_linux%b
   --  END ELABORATION ORDER

end ada_linuxmain;
