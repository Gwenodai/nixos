# Declare tools for use in implementing the dendritic pattern
{ den, inputs, ... }: {
  imports = [
    ( inputs.flake-file.flakeModules.dendritic or {} )
    ( inputs.den.flakeModules.dendritic or {} )
  ];
  
  # Flake inputs
  flake-file.inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-file.url = "github:vic/flake-file";
    den.url = "github:vic/den";
  };

  # Enable the use of den's angle brackets syntax
  # https://den.oeiuwq.com/guides/angle-brackets
  _module.args.__findFile = den.lib.__findFile;

  # Define avialable systems
  systems = [
    # "aarch64-linux"
    "x86_64-linux"
  ];
}