with Interfaces.C; use Interfaces.C;

package stub is

   procedure do_exit (a : int)
     with
       Export        => True,
       Convention    => C,
       External_Name => "do_exit";

end stub;