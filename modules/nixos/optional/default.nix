{
  lib,
  ...
}:

# Automatically import all directories with 'default.nix' files
let
  inherit
    (builtins)
      filter
      map
      readDir
      pathExists
      attrNames;
  isDirectory = _: type: type == "directory";
  hasDefault = name: pathExists (./. + "/${name}/default.nix");
in {
  imports = lib.pipe ./. [
    # Read the current directory
    readDir
    # Keep only directories
    (lib.filterAttrs isDirectory)
    # Get the names of the directories
    attrNames
    # Keep only those with a default.nix
    (filter hasDefault)
    # Convert names to full paths
    (map (name: ./. + "/${name}"))
  ];
}