package ada_linux is

    procedure ada_init_module with
        export        => true,
        convention    => c,
        external_name => "ada_init_module";

    procedure ada_cleanup_module with
        export        => true,
        convention    => c,
        external_name => "ada_cleanup_module";

end ada_linux;
