{ den, ... }: {
  den.aspects.fonts = {
    includes = with den.aspects.fonts._; [
      regular
      nerd
    ];

    _.config = {
      nixos.fonts.fontconfig.enable = true;
      persistUserIgnore = { hmConfig, ... }: {
        directories = [ "${hmConfig.xdg.cacheHome}/fontconfig" ];
      };
    };

    _.regular = {
      includes = [ den.aspects.fonts._.config ];
      nixos = { pkgs, ... }: {
        # Regular fonts
        fonts.packages = with pkgs; [
          fira
          jetbrains-mono
          adwaita-fonts
          googlesans-code
        ];
      };
    };

    _.nerd = {
      includes = [ den.aspects.fonts._.config ];
      nixos = { pkgs, ... }: {
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
  };
}
