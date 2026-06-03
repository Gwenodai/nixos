{
  den.aspects.fonts = {
    nixos =
      { pkgs, ... }:
      {
        fonts.fontconfig.enable = true;

        fonts.packages =
          (with pkgs; [
            # Regular fonts
            fira
            jetbrains-mono
            adwaita-fonts
            googlesans-code
          ])
          ++ (with pkgs.nerd-fonts; [
            # Nerd-fonts
            symbols-only
            fira-mono
            fira-code
            adwaita-mono
            jetbrains-mono
          ]);
      };

    persistUserIgnore =
      { hmConfig, ... }:
      {
        directories = [ "${hmConfig.xdg.cacheHome}/fontconfig" ];
      };
  };
}
