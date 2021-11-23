------------------------------------------------------------------------------
--                                                                          --
--                         GNAT COMPILER COMPONENTS                         --
--                                                                          --
--                  S Y S T E M . G C C . D I V _ M O D _ 3                 --
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

--  Ada generic implementation for libgcc: 64 and 128-bit Divisions

package body System.GCC.Div_Mod3 is

   ---------------
   -- Divmod3 --
   ---------------

   function Divmod3 (Num : DW;
                     Den : DW;
                     Return_Rem : Boolean)
                     return DW
   is
      pragma Suppress (All_Checks);
      Neg       : Boolean := False;
      N         : UDW;
      D         : UDW;
      R         : UDW;
      Remainder : aliased UDW;
      Res       : DW;
   begin
      if Num < 0 then
         Neg := True;
         N := UDW (-Num);
      else
         N := UDW (Num);
      end if;

      if Den < 0 then
         Neg := not Neg;
         D := UDW (-Den);
      else
         D := UDW (Den);
      end if;

      R := Udivmod4 (N, D, Remainder'Access);

      --  The remainder has the sign of the numerator
      if Return_Rem then
         Neg := Num < 0;
         R   := Remainder;
      end if;

      if Neg then
         Res := -DW (R);
      else
         Res := DW (R);
      end if;

      return Res;
   end Divmod3;

end System.GCC.Div_Mod3;
