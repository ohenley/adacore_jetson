package Flash_Led is

   procedure Ada_Init_Module with
      Export        => True,
      Convention    => C,
      External_Name => "ada_init_module";

   procedure Ada_Cleanup_Module with
      Export        => True,
      Convention    => C,
      External_Name => "ada_cleanup_module";

end Flash_Led;
