{ inputs, den, ... }: {
  flake-file.inputs.stylix = {
    url = "github:nix-community/stylix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.stylix = {
    includes = with den.aspects.stylix._; [ enable ];

    _.enable = {
      nixos = { pkgs, lib, ... }: {
        imports = [ inputs.stylix.nixosModules.stylix ];
        stylix = {
          enable = lib.mkDefault true;
          autoEnable = lib.mkDefault false;
          polarity = "dark";
          base16Scheme = lib.mkDefault "${pkgs.base16-schemes}/share/themes/pinky.yaml";
          override = lib.mkDefault {
            base00 = "121012";
            base02 = "b5b0b5";
            base0C = "a972fc";
          };

          cursor = lib.mkDefault {
            name = "Vimix-cursors";
            package = pkgs.vimix-cursors;
            size = 24;
          };

          icons = lib.mkDefault {
            enable = true;
            package = pkgs.papirus-icon-theme.override {
              color = "pink";
            };
            light = "Papirus-Light";
            dark = "Papirus-Dark";
          };

          fonts = {
            serif = lib.mkDefault {
              name = "Adwaita Sans";
              package = pkgs.adwaita-fonts;
            };
            sansSerif = lib.mkDefault {
              name = "Adwaita Sans";
              package = pkgs.adwaita-fonts;
            };
            monospace = lib.mkDefault {
              name = "JetBrainsMono Nerd Font Mono";
              package = pkgs.nerd-fonts.jetbrains-mono;
            };
            emoji = lib.mkDefault {
              package = pkgs.noto-fonts-color-emoji;
              name = "Noto Color Emoji";
            };
            sizes = lib.mkDefault {
              terminal = 11;
            };
          };
          
          opacity.terminal = lib.mkDefault 0.4;

          targets = {
            gtk.enable = lib.mkDefault true;
            qt.enable = lib.mkDefault true;
          };
        };
      };

      homeManager = { config, lib, ... }: {
        stylix.targets = {
          gtk = lib.mkDefault {
            enable = true;
            flatpakSupport.enable = true;
            # Force dialog buttons to use white text
            extraCss = ''
              dialog button, .dialog-action-area > .text-button {
                color: @theme_text_color; 
              }
            '';
          };

          kitty.enable = lib.mkDefault true;
          btop.enable = lib.mkDefault true;
          qt.enable = lib.mkDefault true;
        };
        
        dconf.settings."org/gnome/desktop/interface" = {
          color-scheme = lib.mkDefault "prefer-dark";
        };

        # Clean up dots
        xresources.path = lib.mkDefault "${config.xdg.configHome}/X11/xresources";
        home.sessionVariables = {
          XCOMPOSECACHE = lib.mkDefault "${config.xdg.cacheHome}/X11/xcompose";
        };

        # TODO: Niri settings
        # programs.niri.settings.spawn-at-startup = [
        #   { sh = "${pkgs.xrdb}/bin/xrdb -merge ${config.xresources.path}"; }
        # ];
      };
    };
  };
}
