# Declare tools for use in implementing the dendritic pattern
{ den, ... }:
{
  # Enable the use of den's angle brackets syntax
  # https://den.oeiuwq.com/guides/angle-brackets
  _module.args.__findFile = den.lib.__findFile;

  den.default.includes = [
    # ${user}._.${host} and ${host}._.${user}
    den._.mutual-provider
    # Provides flake-parts inputs' (system-specialized inputs) as a module argument
    den._.inputs'
    # Provides flake-parts self' (system-specialized self) as a module argument
    den._.self'
  ];

  # Define avialable systems
  systems = [
    # "aarch64-linux"
    "x86_64-linux"
  ];
}
