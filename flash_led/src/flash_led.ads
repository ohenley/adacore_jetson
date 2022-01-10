Package Flash_Led Is

    Procedure Ada_Init_Module With
        Export        => True,
        Convention    => C,
        External_Name => "ada_init_module";

    Procedure Ada_Cleanup_Module With
        Export        => True,
        Convention    => C,
        External_Name => "ada_cleanup_module";

End Flash_Led;
