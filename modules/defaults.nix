{ den, ... }:
{
  ### DEBUG FLAG ####
  flake.den = den;

  systems = [
    "x86_64-linux"
    # "aarch64-linux"
  ];

  # Enables the use of den's angle brackets syntax
  _module.args.__findFile = den.lib.__findFile;

  ### Global Aspects
  den.default.includes = [
    # Provides flake-parts inputs' (system-specialized inputs) as a module argument
    den.batteries.inputs'
    # Provides flake-parts self' (system-specialized self) as a module argument
    den.batteries.self'
    # Automatically set hostname based on host
    den.batteries.hostname
    # Automatically create the user on host
    den.batteries.define-user
    # Sets the default shell to zsh
    (den.batteries.user-shell "zsh")
  ];

  ### Host Aspects
  den.schema.host.includes = with den.aspects; [
    # Automatically configures core hardware functionality based on the provided
    # host hardware profile configuration defined within `./hosts.nix`
    hardware.autoConfig
    # Use the latest NixOS kernel by default
    kernel
    # Declarative disk partitioning and formatting using nix
    disko
  ];

  ### User Aspects
  den.schema.user.includes = with den.aspects; [
    # Inserts specific authorised ssh keys by default in all users
    lib.ssh.authorizedKeys
  ];
}
