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
  den.default.includes = with den.aspects; [
    den.batteries.inputs'
    den.batteries.self'
    den.batteries.hostname
    # Automatically create the user on host
    den.batteries.define-user
    # Sets the default shell to zsh
    (den.batteries.user-shell "zsh")
    home-manager.userConfig
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
    # Secrets management
    sops-nix.hostConfig
  ];

  ### Home-Manager Host Aspects
  den.schema.hm-host.includes = with den.aspects; [
    home-manager.hostConfig
  ];

  ### User Aspects
  den.schema.user.includes = with den.aspects; [
    # Secrets management
    sops-nix.userConfig
    # Inserts specific authorised ssh keys by default in all users
    lib.ssh.authorizedKeys
  ];
}
