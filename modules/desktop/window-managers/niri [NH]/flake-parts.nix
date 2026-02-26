# Niri window manager
# https://github.com/niri-wm/niri
{
  ...
}: {
  flake-file.inputs = {
    niri = {
      # url = "github:sodiboo/niri-flake";
      url = "github:cmm/niri-flake/add-extraConfig";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}