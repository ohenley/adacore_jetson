with system;
with kernel; use kernel;

package flash_led is

    procedure ada_init_module with
        export        => true,
        convention    => c,
        external_name => "ada_init_module";

    procedure ada_cleanup_module with
        export        => true,
        convention    => c,
        external_name => "ada_cleanup_module";

end flash_led;
