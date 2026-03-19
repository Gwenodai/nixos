{ den, ... }: {
  den.aspects.fonts = {
    includes = with den.aspects.fonts._; [
      regular
      nerd
    ];

     _.config = den.lib.perHost {
      nixos = { lib, ... }: {
        fonts.fontconfig.enable = lib.mkDefault true;
      };
      persistUserIgnore = { hmConfig, ... }: {
        directories = [ "${hmConfig.xdg.cacheHome}/fontconfig" ];
      };
    };

    _.regular = den.lib.perHost {
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

    _.nerd = den.lib.perHost {
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
