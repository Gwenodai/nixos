{ den, ... }:
{
  # These are global static settings
  den.default.includes = [
    # ${user}._.${host} and ${host}._.${user}
    den._.mutual-provider
    # Provides flake-parts inputs' (system-specialized inputs) as a module argument
    den._.inputs'
    # Provides flake-parts self' (system-specialized self) as a module argument
    den._.self'
  ];
}
