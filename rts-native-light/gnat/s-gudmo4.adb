------------------------------------------------------------------------------
--                                                                          --
--                         GNAT COMPILER COMPONENTS                         --
--                                                                          --
--                S Y S T E M . G C C . U D I V _ M O D _ 4                 --
--                                                                          --
--                                 B o d y                                  --
--                                                                          --
--          Copyright (C) 2013-2021, Free Software Foundation, Inc.         --
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

--  Ada implementation of libgcc: 64 and 128-bit Divisions

package body System.GCC.Udiv_Mod_4 is

   function Shift_Left
     (Value  : UDW;
      Amount : Natural) return  UDW
      with Import, Convention => Intrinsic;

   function Shift_Left
     (Value  : UW;
      Amount : Natural) return  UW
      with Import, Convention => Intrinsic;

   function Shift_Right
     (Value  : UW;
      Amount : Natural) return  UW
      with Import, Convention => Intrinsic;

   function Count_Leading_Zero (V : UW) return Natural;
   pragma Import (Intrinsic, Count_Leading_Zero, "__builtin_clzl");
   --  Return the number of consecutive zero in V, starting from the MSB.
   --  The result is between 0 and 64 or 0 and 32.

   ----------------
   -- Udivmod4 --
   ----------------

   pragma Annotate (Gnatcheck, Exempt_On, "Metrics_Cyclomatic_Complexity",
                    "performance issues");

   function Udivmod4 (Num : UDW; Den : UDW; Remainder : access UDW) return UDW
   is
      pragma Suppress (All_Checks);
      Den_Sh, Num_Sh : Natural;
      --  Number of leading zero in denominator and numerator

      Diff_Sh : Natural;

      D1, D0 : UW;
      --  High and low part of Den

      N1, N0 : UW;
      --  High and low part of Num
   begin
      Split (Num, N1, N0);
      Split (Den, D1, D0);

      if D1 = 0 then
         --  Small denominator

         if N1 = 0 then
            --  UW_Size bit division

            declare
               Q0 : UW;
            begin
               Q0 := N0 / D0;

               if Remainder /= null then
                  Remainder.all := UDW (N0 - Q0 * D0);
               end if;

               pragma Annotate (Gnatcheck, Exempt_On, "Improper_Returns",
                                "early return for performance");

               return UDW (Q0);

               pragma Annotate (Gnatcheck, Exempt_Off, "Improper_Returns");
            end;

         elsif D0 < 2**UW_Half_Size then
            --  Use pencil and paper algorithm, using D0 as single digit. The
            --  quotient is Q2:Q1:Q0.

            declare
               Q2, Q1, Q0 : UW;
            begin
               --  First digit
               Q2 := N1 / D0;
               N1 := N1 - Q2 * D0;  --  Less than 2**UW_Half_Size
               N1 := Shift_Left (N1, UW_Half_Size)
                     or Shift_Right (N0, UW_Half_Size);

               --  Second digit
               Q1 := N1 / D0;
               N1 := N1 - Q1 * D0;  --  Less than 2**UW_Half_Size
               N1 := Shift_Left (N1, UW_Half_Size) or (N0 and UW_Half_Mask);

               --  Third digit
               Q0 := N1 / D0;

               if Remainder /= null then
                  Remainder.all := UDW (N1 - Q0 * D0);
               end if;

               pragma Annotate (Gnatcheck, Exempt_On, "Improper_Returns",
                                "early return for performance");

               return Merge (Q2, Shift_Left (Q1, UW_Half_Size) or Q0);

               pragma Annotate (Gnatcheck, Exempt_Off, "Improper_Returns");
            end;
         end if;

         Den_Sh := UW_Size + Count_Leading_Zero (D0);
      else
         Den_Sh := Count_Leading_Zero (D1);
      end if;

      --  Number of leading zero for the numerator
      if N1 = 0 then
         Num_Sh := UW_Size + Count_Leading_Zero (N0);
      else
         Num_Sh := Count_Leading_Zero (N1);
      end if;

      if Den_Sh < Num_Sh then
         --  Den < Num, so the quotient is 0

         if Remainder /= null then
            Remainder.all := Num;
         end if;

         pragma Annotate (Gnatcheck, Exempt_On, "Improper_Returns",
                          "early return for performance");

         return 0;

         pragma Annotate (Gnatcheck, Exempt_Off, "Improper_Returns");
      end if;

      --  Align the denominator on the numerator, and use pencil and paper
      --  algorithm in base 2. Nothing special is done for division per 0,
      --  the result isn't meaningful.

      Diff_Sh := Den_Sh - Num_Sh;
      if Diff_Sh > UW_Size then
         D1 := Shift_Left (D0, Diff_Sh - UW_Size);
         D0 := 0;
      else
         D1 := Shift_Left (D1, Diff_Sh) or Shift_Right (D0, UW_Size - Diff_Sh);
         D0 := Shift_Left (D0, Diff_Sh);
      end if;

      declare
         N : UDW := Num;
         Q : UDW := 0;
      begin
         for I in 0 .. Diff_Sh loop
            Q := Shift_Left (Q, 1);

            if N >= Merge (D1, D0) then
               Q := Q or 1;
               N := N - Merge (D1, D0);
            end if;

            D0 := Shift_Right (D0, 1) or Shift_Left (D1, 63);
            D1 := Shift_Right (D1, 1);
         end loop;

         if Remainder /= null then
            Remainder.all := N;
         end if;

         pragma Annotate (Gnatcheck, Exempt_On, "Improper_Returns",
                          "code clearer with 2 returns");

         return Q;

         pragma Annotate (Gnatcheck, Exempt_Off, "Improper_Returns");
      end;
   end Udivmod4;

   pragma Annotate (Gnatcheck, Exempt_Off, "Metrics_Cyclomatic_Complexity");

end System.GCC.Udiv_Mod_4;
