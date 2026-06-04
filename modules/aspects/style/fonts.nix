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

    ### Persist config
    persistUserIgnore =
      { hmConfig, ... }:
      {
        directories = [
          # "~/.cache/fontconfig"
          "${hmConfig.xdg.cacheHome}/fontconfig"
        ];
      };
  };
}
