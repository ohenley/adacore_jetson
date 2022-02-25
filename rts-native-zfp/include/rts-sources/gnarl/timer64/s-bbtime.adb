------------------------------------------------------------------------------
--                                                                          --
--                  GNAT RUN-TIME LIBRARY (GNARL) COMPONENTS                --
--                                                                          --
--                         S Y S T E M . B B . T I M E                      --
--                                                                          --
--                                  B o d y                                 --
--                                                                          --
--        Copyright (C) 1999-2002 Universidad Politecnica de Madrid         --
--             Copyright (C) 2003-2005 The European Space Agency            --
--                     Copyright (C) 2003-2018, AdaCore                     --
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
-- Extensive contributions were provided by Ada Core Technologies Inc.      --
--                                                                          --
-- The port of GNARL to bare board targets was initially developed by the   --
-- Real-Time Systems Group at the Technical University of Madrid.           --
--                                                                          --
------------------------------------------------------------------------------

pragma Restrictions (No_Elaboration_Code);

with System.BB.Interrupts;
with System.BB.Board_Support;
with System.BB.Protection;
with System.BB.Threads.Queues;
with System.BB.Timing_Events;

package body System.BB.Time is

   use System.Multiprocessors;
   use System.BB.Board_Support.Multiprocessors;

   --  We use two timers with the same frequency:
   --     A Periodic Timer for the clock
   --     An Alarm Timer for delays

   -----------------------
   -- Local Subprograms --
   -----------------------

   procedure Alarm_Handler (Interrupt : Interrupts.Interrupt_ID);
   --  Handler for the alarm interrupt

   -------------------
   -- Alarm_Handler --
   -------------------

   procedure Alarm_Handler (Interrupt : Interrupts.Interrupt_ID) is
      pragma Unreferenced (Interrupt);

      Now    : constant Time := Clock;
      CPU_Id : constant CPU  := Current_CPU;

   begin
      Board_Support.Time.Clear_Alarm_Interrupt;

      --  A context switch may happen due to an awaken task. Charge the
      --  current task.

      if Scheduling_Event_Hook /= null then
         Scheduling_Event_Hook.all;
      end if;

      --  Note that the code is executed with interruptions disabled, so there
      --  is no need to call Enter_Kernel/Leave_Kernel.

      --  Execute expired events of the current CPU

      Timing_Events.Execute_Expired_Timing_Events (Now);

      --  Wake up our alarms

      Threads.Queues.Wakeup_Expired_Alarms (Now);

      --  Set the timer for the next alarm on this CPU

      Update_Alarm (Get_Next_Timeout (CPU_Id));

      --  The interrupt low-level handler will call context_switch if necessary

   end Alarm_Handler;

   -----------
   -- Clock --
   -----------

   function Clock return Time is (Board_Support.Time.Read_Clock);

   -----------
   -- Epoch --
   -----------

   function Epoch return Time is
   begin
      --  TBL and TBU cleared at start up

      return 0;
   end Epoch;

   -----------------
   -- Delay_Until --
   -----------------

   procedure Delay_Until (T : Time) is
      Now               : Time;
      Self              : Threads.Thread_Id;
      Inserted_As_First : Boolean;
      CPU_Id            : constant CPU := Current_CPU;

   begin
      --  First mask interrupts, this is necessary to handle thread queues

      Protection.Enter_Kernel;

      --  Read the clock once the interrupts are masked to avoid being
      --  interrupted before the alarm is set.

      Now := Clock;

      Self := Threads.Thread_Self;

      --  Test if the alarm time is in the future

      if T > Now then

         --  Extract the thread from the ready queue. When a thread wants to
         --  wait for an alarm it becomes blocked.

         Self.State := Threads.Delayed;

         Threads.Queues.Extract (Self);

         --  Insert Thread_Id in the alarm queue (ordered by time) and if it
         --  was inserted at head then check if Alarm Time is closer than the
         --  next clock interrupt.

         Threads.Queues.Insert_Alarm (T, Self, Inserted_As_First);

         if Inserted_As_First then
            Update_Alarm (Get_Next_Timeout (CPU_Id));
         end if;

      else
         --  If alarm time is not in the future, the thread must yield the CPU

         Threads.Queues.Yield (Self);
      end if;

      Protection.Leave_Kernel;
   end Delay_Until;

   ----------------------
   -- Get_Next_Timeout --
   ----------------------

   function Get_Next_Timeout (CPU_Id : CPU) return Time is
      Alarm_Time : constant Time :=
                     Threads.Queues.Get_Next_Alarm_Time (CPU_Id);
      Event_Time : constant Time := Timing_Events.Get_Next_Timeout (CPU_Id);

   begin
      return Time'Min (Alarm_Time, Event_Time);
   end Get_Next_Timeout;

   -----------------------
   -- Initialize_Timers --
   -----------------------

   procedure Initialize_Timers is
   begin
      --  Install alarm handler
      Board_Support.Time.Install_Alarm_Handler (Alarm_Handler'Access);
   end Initialize_Timers;

   ------------------
   -- Update_Alarm --
   ------------------

   procedure Update_Alarm (Alarm : Time) is
   begin
      Board_Support.Time.Set_Alarm (Alarm);
   end Update_Alarm;

end System.BB.Time;
