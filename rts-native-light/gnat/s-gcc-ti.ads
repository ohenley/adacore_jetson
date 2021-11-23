------------------------------------------------------------------------------
--                                                                          --
--                         GNAT COMPILER COMPONENTS                         --
--                                                                          --
--                         S Y S T E M . G C C . T I                        --
--                                                                          --
--                                 S p e c                                  --
--                                                                          --
--            Copyright (C) 2013-2021, Free Software Foundation, Inc.       --
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

--  Parent package for Ada implementation of libgcc 128 bit integers
--  @design @internal
--  This package contains subprograms to split a 128 bit value into 2 64 bit
--  ones, and to create a 128 bit value from 2 64 bit ones.

pragma Restrictions (No_Elaboration_Code);

with Interfaces;
--  @design used to get 64 and 128-bit integer types.

package System.GCC.TI is
   pragma Pure;

   subtype Unsigned_128 is Interfaces.Unsigned_128;
   subtype Integer_128 is Interfaces.Integer_128;
   subtype Unsigned_64 is Interfaces.Unsigned_64;
   subtype Integer_64 is Interfaces.Integer_64;
   --  @internal
   --  Renaming to avoid full names in specifications

   procedure Split (Val : Unsigned_128;
                    Hi  : out Unsigned_64;
                    Lo  : out Unsigned_64);
   pragma Inline (Split);
   --  @internal
   --  Extract the most significant half of Val to Hi and the least one to Lo.
   --  The code generated by the compiler should be stand-alone and highly
   --  efficient.

   function Merge (Hi : Unsigned_64; Lo : Unsigned_64) return Unsigned_128;
   pragma Inline (Merge);
   --  @internal
   --  Create an Unsigned_128 from Hi and Lo. The code generated by the
   --  compiler should be stand-alone and highly efficient.

end System.GCC.TI;