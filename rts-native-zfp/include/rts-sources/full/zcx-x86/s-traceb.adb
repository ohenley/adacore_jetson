------------------------------------------------------------------------------
--                                                                          --
--                         GNAT COMPILER COMPONENTS                         --
--                                                                          --
--                     S Y S T E M . T R A C E B A C K                      --
--                                                                          --
--                                 B o d y                                  --
--                                                                          --
--          Copyright (C) 1999-2018, Free Software Foundation, Inc.         --
--                                                                          --
-- GNAT is free software;  you can  redistribute it  and/or modify it under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 3,  or (at your option) any later ver- --
-- sion.  GNAT is distributed in the hope that it will be useful, but WITH- --
-- OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY --
-- or FITNESS FOR A PARTICULAR PURPOSE.                                     --
--                                                                          --
--                                                                          --
--                                                                          --
--                                                                          --
--                                                                          --
-- You should have received a copy of the GNU General Public License and    --
-- a copy of the GCC Runtime Library Exception along with this program;     --
-- see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see    --
-- <http://www.gnu.org/licenses/>.                                          --
--                                                                          --
-- GNAT was originally developed  by the GNAT team at  New York University. --
-- It is now maintained by Ada Core Technologies Inc (http://www.gnat.com). --
--                                                                          --
------------------------------------------------------------------------------

with System.Address_To_Access_Conversions;
with System.Machine_Code; use System.Machine_Code;

--  This version is for the AE653 Level A runtime, VxSim

package body System.Traceback is

   package Addr is new System.Address_To_Access_Conversions (System.Address);
   use Addr;

   procedure Call_Chain
     (Traceback   : in out System.Traceback_Entries.Tracebacks_Array;
      Max_Len     : Natural;
      Len         : out Natural;
      Exclude_Min : System.Address := System.Null_Address;
      Exclude_Max : System.Address := System.Null_Address;
      Skip_Frames : Natural := 1) is

      Frame_Link_Offset     : constant System.Address := 0;
      --  Offset of memory location where address of previous frame
      --  is stored, relative to current frame. This must be
      --  a multiple of System.Address'Alignment.
      pragma Assert (Frame_Link_Offset mod System.Address'Alignment = 0);

      Return_Address_Offset : constant System.Address := 4;
      --  Offset in bytes where return address of current frame stored,
      --  relative to current frame.
      pragma Assert (Return_Address_Offset mod System.Address'Alignment = 0);

      PC_Adjust : constant := 2;
      --  Size of call instruction to subtract from return address to
      --  get the PC for the calling frame.

      Frame : System.Address;
      --  Frame being processed

      Top_Of_Stack : System.Address;
      --  Address of top frame

      Last  : Integer := Traceback'First - 1;
      --  Index of last traceback written to the buffer

   begin
      Len := 0;

      --  Move contents of FP

      Asm ("mov %%ebp, %0",
           Outputs  => Address'Asm_Output ("=r", Frame),
           Volatile => True);

      --  Set to correct frame location, with correct return address

      Top_Of_Stack := Frame;

      --  Exclude Skip_Frames frames from the traceback

      for J in 1 .. Skip_Frames - 1 loop
         if Frame = System.Null_Address
           or else Frame mod System.Address'Alignment /= 0
           or else To_Pointer (Frame).all = System.Null_Address
           or else To_Pointer (Frame + Return_Address_Offset).all <=
                                            System.Null_Address
           or else Frame < Top_Of_Stack
         then
            --  Something is wrong. Skip_Frames > the number of frames on the
            --  current stack. Do not return a trace.

            return;
         end if;

         Frame := To_Pointer (Frame).all;
      end loop;

      pragma Assert (Frame /= System.Null_Address);

      while Frame mod System.Address'Alignment = 0
        and then To_Pointer (Frame).all /= System.Null_Address
        and then To_Pointer (Frame + Return_Address_Offset).all >
                                           System.Null_Address
        and then Frame >= Top_Of_Stack
        and then Last < Traceback'Last
        and then Len < Max_Len
      loop
         declare
            PC : constant System.Address :=
                   To_Pointer (Frame + Return_Address_Offset).all - PC_Adjust;

         begin
            if PC not in Exclude_Min .. Exclude_Max then

               --  Skip Ada.Exceptions routines

               Last := Last + 1;
               Len := Len + 1;
               Traceback (Last) := PC;
            end if;

            Frame := To_Pointer (Frame).all;
         end;

         pragma Assert (Frame /= System.Null_Address);
      end loop;
   end Call_Chain;

end System.Traceback;
