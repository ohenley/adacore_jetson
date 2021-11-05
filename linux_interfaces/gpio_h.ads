with Interfaces.C;
with Interfaces.C.Strings;
-- /home/henley/cross/linux/include/linux/gpio.h
package Gpio_H is
   -- gpio.h:  50
   type Gpio is record
      Gpio : Interfaces.C.Unsigned;
      Flags : Interfaces.C.Unsigned_Long;
      Label : Interfaces.C.Strings.Chars_Ptr;
   end record
   with Convention => C_Pass_By_Copy;

   -- gpio.h:  106
   type Device is null record 
      with Convention => C_Pass_By_Copy;
   -- gpio.h:  107
   type Gpio_Chip is null record 
      with Convention => C_Pass_By_Copy;
   -- gpio.h:  109
   function Gpio_Is_Valid return Interfaces.C.Int
   with Import => True,
        Convention => C,
        External_Name => "gpio_is_valid";

   -- gpio.h:  114
   function Gpio_Request (
      Gpio : Interfaces.C.Unsigned;
      Label : Interfaces.C.Strings.Chars_Ptr)
      return Interfaces.C.Int
   with Import => True,
        Convention => C,
        External_Name => "gpio_request";

   -- gpio.h:  119
   function Gpio_Request_One (
      Gpio : Interfaces.C.Unsigned;
      Flags : Interfaces.C.Unsigned_Long;
      Label : Interfaces.C.Strings.Chars_Ptr)
      return Interfaces.C.Int
   with Import => True,
        Convention => C,
        External_Name => "gpio_request_one";

   -- gpio.h:  125
   function Gpio_Request_Array (
      C_Array : access Gpio;
      Num : Interfaces.C.Int)
      return Interfaces.C.Int
   with Import => True,
        Convention => C,
        External_Name => "gpio_request_array";

   -- gpio.h:  130
   procedure Gpio_Free (
      Gpio : Interfaces.C.Unsigned)
   with Import => True,
        Convention => C,
        External_Name => "gpio_free";

   -- gpio.h:  138
   procedure Gpio_Free_Array (
      C_Array : access Gpio;
      Num : Interfaces.C.Int)
   with Import => True,
        Convention => C,
        External_Name => "gpio_free_array";

   -- gpio.h:  146
   function Gpio_Direction_Input (
      Gpio : Interfaces.C.Unsigned)
      return Interfaces.C.Int
   with Import => True,
        Convention => C,
        External_Name => "gpio_direction_input";

   -- gpio.h:  151
   function Gpio_Direction_Output (
      Gpio : Interfaces.C.Unsigned;
      Value : Interfaces.C.Int)
      return Interfaces.C.Int
   with Import => True,
        Convention => C,
        External_Name => "gpio_direction_output";

   -- gpio.h:  156
   function Gpio_Set_Debounce (
      Gpio : Interfaces.C.Unsigned;
      Debounce : Interfaces.C.Unsigned)
      return Interfaces.C.Int
   with Import => True,
        Convention => C,
        External_Name => "gpio_set_debounce";

   -- gpio.h:  161
   function Gpio_Get_Value (
      Gpio : Interfaces.C.Unsigned)
      return Interfaces.C.Int
   with Import => True,
        Convention => C,
        External_Name => "gpio_get_value";

   -- gpio.h:  168
   procedure Gpio_Set_Value (
      Gpio : Interfaces.C.Unsigned;
      Value : Interfaces.C.Int)
   with Import => True,
        Convention => C,
        External_Name => "gpio_set_value";

   -- gpio.h:  174
   function Gpio_Cansleep (
      Gpio : Interfaces.C.Unsigned)
      return Interfaces.C.Int
   with Import => True,
        Convention => C,
        External_Name => "gpio_cansleep";

   -- gpio.h:  181
   function Gpio_Get_Value_Cansleep (
      Gpio : Interfaces.C.Unsigned)
      return Interfaces.C.Int
   with Import => True,
        Convention => C,
        External_Name => "gpio_get_value_cansleep";

   -- gpio.h:  188
   procedure Gpio_Set_Value_Cansleep (
      Gpio : Interfaces.C.Unsigned;
      Value : Interfaces.C.Int)
   with Import => True,
        Convention => C,
        External_Name => "gpio_set_value_cansleep";

   -- gpio.h:  194
   function Gpio_Export (
      Gpio : Interfaces.C.Unsigned;
      Direction_May_Change : Interfaces.C.Int)
      return Interfaces.C.Int
   with Import => True,
        Convention => C,
        External_Name => "gpio_export";

   -- gpio.h:  201
   function Gpio_Export_Link (
      Dev : access Device;
      Name : Interfaces.C.Strings.Chars_Ptr;
      Gpio : Interfaces.C.Unsigned)
      return Interfaces.C.Int
   with Import => True,
        Convention => C,
        External_Name => "gpio_export_link";

   -- gpio.h:  209
   procedure Gpio_Unexport (
      Gpio : Interfaces.C.Unsigned)
   with Import => True,
        Convention => C,
        External_Name => "gpio_unexport";

   -- gpio.h:  215
   function Gpio_To_Irq (
      Gpio : Interfaces.C.Unsigned)
      return Interfaces.C.Int
   with Import => True,
        Convention => C,
        External_Name => "gpio_to_irq";

   -- gpio.h:  222
   function Irq_To_Gpio (
      Irq : Interfaces.C.Unsigned)
      return Interfaces.C.Int
   with Import => True,
        Convention => C,
        External_Name => "irq_to_gpio";

   -- gpio.h:  229
   function Devm_Gpio_Request (
      Dev : access Device;
      Gpio : Interfaces.C.Unsigned;
      Label : Interfaces.C.Strings.Chars_Ptr)
      return Interfaces.C.Int
   with Import => True,
        Convention => C,
        External_Name => "devm_gpio_request";

   -- gpio.h:  236
   function Devm_Gpio_Request_One (
      Dev : access Device;
      Gpio : Interfaces.C.Unsigned;
      Flags : Interfaces.C.Unsigned_Long;
      Label : Interfaces.C.Strings.Chars_Ptr)
      return Interfaces.C.Int
   with Import => True,
        Convention => C,
        External_Name => "devm_gpio_request_one";

   -- gpio.h:  243
   procedure Devm_Gpio_Free (
      Dev : access Device;
      Gpio : Interfaces.C.Unsigned)
   with Import => True,
        Convention => C,
        External_Name => "devm_gpio_free";

end Gpio_H;
