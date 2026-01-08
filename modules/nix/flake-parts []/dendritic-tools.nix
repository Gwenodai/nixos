{
  inputs,
  ...
}:

{
  imports = [
    # https://flake.parts/options/flake-parts-modules.html
    inputs.flake-parts.flakeModules.modules
  ];

  # set flake.systems
  systems = [
    "x86_64-linux"
  ];
}