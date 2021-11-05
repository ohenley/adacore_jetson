--pragma Restrictions (No_Secondary_Stack);

--with Interfaces.C;

with system;
package ada_linux is

    procedure Last_Chance_Handler (Msg : System.Address; Line : Integer);
    pragma Export (C, Last_Chance_Handler, "__gnat_last_chance_handler");
    
    procedure Call_Last_Chance_Handler_With_Message (Message : String);
    pragma Export (C, Call_Last_Chance_Handler_With_Message, "ada__exceptions__call_last_chance_handler_with_message");

    procedure ada_init_module with
        Export        => True,
        Convention    => C,
        External_Name => "ada_init_module";

    procedure ada_cleanup_module with
        Export        => True,
        Convention    => C,
        External_Name => "ada_cleanup_module";

end ada_linux;
