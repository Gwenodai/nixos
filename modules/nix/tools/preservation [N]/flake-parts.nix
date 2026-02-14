# Ephemeral state management
# https://nix-community.github.io/preservation/configuration-options.html
{
  ...
}: {
  flake-file.inputs = {
    preservation.url = "github:nix-community/preservation";
  };
}