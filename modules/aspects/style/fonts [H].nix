{ den, ... }:
let
  config = {
    nixos = {
      fonts.fontconfig.enable = true;
    };

    persistUserIgnore =
      { hmConfig, ... }:
      {
        directories = [ "${hmConfig.xdg.cacheHome}/fontconfig" ];
      };
  };

  regular = {
    nixos =
      { pkgs, ... }:
      {
        # Regular fonts
        fonts.packages = with pkgs; [
          fira
          jetbrains-mono
          adwaita-fonts
          googlesans-code
        ];
      };
  };

  nerd = {
    nixos =
      { pkgs, ... }:
      {
        # Nerd-fonts
        fonts.packages = with pkgs.nerd-fonts; [
          symbols-only
          fira-mono
          fira-code
          adwaita-mono
          jetbrains-mono
        ];
      };
  };
in
{
  den.aspects.fonts.includes = [
    config
    regular
    nerd
  ];
}
