{
  inputs,
  ...
}: {
  imports = [
    # https://flake.parts/options/flake-parts-modules.html
    inputs.flake-parts.flakeModules.modules
  ];

  # Define flake.systems
  systems = [
    "x86_64-linux"
  ];
}