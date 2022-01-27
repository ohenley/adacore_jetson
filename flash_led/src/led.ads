With Controllers;
Package Led Is

   Package C Renames Controllers;

   Type State Is (Low, High);
   Type Led_Type (Size : Natural) Is Tagged Private;

   subtype Tag is String;

   Procedure Init       (L : Out Led_Type; P : C.Pin; T : Tag; S : State);
   Procedure Flip_State (L : In Out Led_Type);
   Procedure Final      (L : Led_Type);

private

   For State Use (Low => 0, High => 1);

   Function "not" (S : State) Return State Is
       (If S = High Then Low Else High);

   Type Led_Type (Size : Natural) Is Tagged Record
       P     : C.Pin;
       T     : Tag (1 .. Size);
       S     : State;
   End Record;

End Led;
