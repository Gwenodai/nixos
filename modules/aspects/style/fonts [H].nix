{ den, ... }:
let
  config = den.lib.perHost {
    nixos = {
      fonts.fontconfig.enable = true;
    };

    persistUserIgnore =
      { hmConfig, ... }:
      {
        directories = [ "${hmConfig.xdg.cacheHome}/fontconfig" ];
      };
  };

  regular = den.lib.perHost {
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

  nerd = den.lib.perHost {
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
