with Controllers;
package Led is

   package C renames Controllers;

   type State is (Off, On);
   type Led_Type (Size : Natural) is private;

   subtype Tag is String;

   procedure Init (L : out Led_Type; P : C.Pin_Data; T : Tag; S : State);
   procedure Flip_State (L : in out Led_Type);
   procedure Final (L : Led_Type);

private

   for State use (Off => 0, On => 1);

   function "not" (S : State) return State is (if S = On then Off else On);

   type Led_Type (Size : Natural) is record
      P : C.Pin_Data;
      T : Tag (1 .. Size);
      S : State;
   end record;

end Led;
