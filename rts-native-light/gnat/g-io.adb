------------------------------------------------------------------------------
--                                                                          --
--                         GNAT RUN-TIME COMPONENTS                         --
--                                                                          --
--                              G N A T . I O                               --
--                                                                          --
--                                 B o d y                                  --
--                                                                          --
--                     Copyright (C) 1995-2021, AdaCore                     --
--                                                                          --
-- GNAT is free software;  you can  redistribute it  and/or modify it under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 3,  or (at your option) any later ver- --
-- sion.  GNAT is distributed in the hope that it will be useful, but WITH- --
-- OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY --
-- or FITNESS FOR A PARTICULAR PURPOSE.                                     --
--                                                                          --
-- As a special exception under Section 7 of GPL version 3, you are granted --
-- additional permissions described in the GCC Runtime Library Exception,   --
-- version 3.1, as published by the Free Software Foundation.               --
--                                                                          --
-- You should have received a copy of the GNU General Public License and    --
-- a copy of the GCC Runtime Library Exception along with this program;     --
-- see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see    --
-- <http://www.gnu.org/licenses/>.                                          --
--                                                                          --
-- GNAT was originally developed  by the GNAT team at  New York University. --
-- Extensive contributions were provided by Ada Core Technologies Inc.      --
--                                                                          --
------------------------------------------------------------------------------

--  Ghost code, loop invariants and assertions in this unit are meant for
--  analysis only, not for run-time checking, as it would be too costly
--  otherwise. This is enforced by setting the assertion policy to Ignore.

pragma Assertion_Policy (Ghost          => Ignore,
                         Loop_Invariant => Ignore,
                         Assert         => Ignore);

with Ada.Numerics.Big_Numbers.Big_Integers;
use Ada.Numerics.Big_Numbers.Big_Integers;

package body GNAT.IO
with
  SPARK_Mode,
  Refined_State => (File_System => null)
is

   procedure Put (C : Character) is separate;

   --------------
   -- New_Line --
   --------------

   procedure New_Line (Spacing : Positive := 1) is
   begin
      for J in 1 .. Spacing loop
         Put (ASCII.LF);
      end loop;
   end New_Line;

   ---------
   -- Put --
   ---------

   procedure Put (X : Integer) is

      procedure Lemma_Div_Commutation (X, Y : Integer)
      with
        Ghost,
        Pre  => Y > 0,
        Post => Big (X) / Big (Y) = Big (X / Y);
      --  Ghost lemma stating that division and conversion commute

      procedure Lemma_Div_Twice (X : Big_Natural; Y, Z : Big_Positive)
      with
        Ghost,
        Post => X / Y / Z = X / (Y * Z);
      --  Ghost lemma stating that double division is equivalent to division by
      --  the product of divisors.

      package Signed_Conversion is new Signed_Conversions (Int => Integer);

      function Big (Arg : Integer) return Big_Integer is
        (Signed_Conversion.To_Big_Integer (Arg))
      with Ghost;

      ---------------------------
      -- Lemma_Div_Commutation --
      ---------------------------

      procedure Lemma_Div_Commutation (X, Y : Integer) is
      begin
         null;
      end Lemma_Div_Commutation;

      ---------------------
      -- Lemma_Div_Twice --
      ---------------------

      procedure Lemma_Div_Twice (X : Big_Natural; Y, Z : Big_Positive) is
         XY  : constant Big_Natural := X / Y;
         YZ  : constant Big_Natural := Y * Z;
         XYZ : constant Big_Natural := X / Y / Z;
         R   : constant Big_Natural := (XY rem Z) * Y + (X rem Y);
      begin
         pragma Assert (X = XY * Y + (X rem Y));
         pragma Assert (XY = XY / Z * Z + (XY rem Z));
         pragma Assert (X = XYZ * YZ + R);
         pragma Assert ((XY rem Z) * Y <= (Z - 1) * Y);
         pragma Assert (R <= YZ - 1);
         pragma Assert (X / YZ = (XYZ * YZ + R) / YZ);
         pragma Assert (X / YZ = XYZ + R / YZ);
      end Lemma_Div_Twice;

      --  Local variables

      Big_10 : constant Big_Integer := Big (10) with Ghost;

      Int   : Integer;
      S     : String (1 .. Integer'Width) with Relaxed_Initialization;
      First : Natural := S'Last + 1;
      Val   : Integer;

      Pow      : Big_Integer := 1 with Ghost;
      Int_Init : Integer with Ghost;

   --  Start of processing for Put

   begin
      --  Work on negative values to avoid overflows
      Int := (if X < 0 then X else -X);
      Int_Init := Int;

      loop
         Lemma_Div_Commutation (Int, 10);
         Lemma_Div_Twice
           (-Big (Int_Init), Big_10 ** (S'Last + 1 - First), Big_10);

         --  Cf RM 4.5.5 Multiplying Operators.  The rem operator will return
         --  negative values for negative values of Int.
         Val := Int rem 10;
         Int := (Int - Val) / 10;
         First := First - 1;
         S (First) := Character'Val (Character'Pos ('0') - Val);

         Pow := Pow * 10;

         pragma Loop_Variant (Increases => Int);
         pragma Loop_Invariant (First in 2 .. S'Last);
         pragma Loop_Invariant (Pow = Big_10 ** (S'Last + 1 - First));
         pragma Loop_Invariant (-Big (Int) = (-Big (Int_Init)) / Pow);
         pragma Loop_Invariant (S (First .. S'Last)'Initialized);

         exit when Int = 0;
      end loop;

      if X < 0 then
         First := First - 1;
         S (First) := '-';
      end if;

      Put (S (First .. S'Last));
   end Put;

   ---------
   -- Put --
   ---------

   procedure Put (S : String) is
   begin
      for J in S'Range loop
         Put (S (J));
      end loop;
   end Put;

   --------------
   -- Put_Line --
   --------------

   procedure Put_Line (S : String) is
   begin
      Put (S);
      New_Line;
   end Put_Line;

end GNAT.IO;
