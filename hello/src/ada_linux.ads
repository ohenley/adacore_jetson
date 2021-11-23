-- with system;
package ada_linux is

    procedure ada_init_module with
        Export        => True,
        Convention    => C,
        External_Name => "ada_init_module";

    procedure ada_cleanup_module with
        Export        => True,
        Convention    => C,
        External_Name => "ada_cleanup_module";

end ada_linux;
