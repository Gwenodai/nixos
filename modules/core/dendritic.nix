# Declare tools for use in implementing the dendritic pattern
{
  inputs,
  ...
}: {
  imports = [
    (inputs.flake-file.flakeModules.dendritic or { })
    (inputs.den.flakeModules.dendritic or { })
  ];
  
  flake-file.inputs = {
    den.url = "github:vic/den";
    flake-file.url = "github:vic/flake-file";
  };

  # Define avialable systems
  systems = [
    # "aarch64-linux"
    "x86_64-linux"
  ];
}