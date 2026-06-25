{ inputs, ... }:
{
  flake-file.inputs.stylix = {
    url = "github:nix-community/stylix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.stylix = {
    nixos =
      {
        config,
        host,
        lib,
        pkgs,
        ...
      }:
      {
        imports = [ inputs.stylix.nixosModules.stylix ];

        stylix = {
          enable = true;
          homeManagerIntegration.autoImport = true;
          homeManagerIntegration.followSystem = true;
          autoEnable = false;
          polarity = "dark";
          base16Scheme = "${pkgs.base16-schemes}/share/themes/pinky.yaml";
          override = {
            base00 = "121012";
            base02 = "b5b0b5";
            base0C = "8b3ffc";
            base0D = "fa3ebe";
          };

          cursor = {
            name = "Vimix-cursors";
            package = pkgs.vimix-cursors;
            size = 24;
          };

          icons = {
            enable = true;
            package = pkgs.papirus-icon-theme.override {
              color = "pink";
            };
            light = "Papirus-Light";
            dark = "Papirus-Dark";
          };

          fonts = {
            serif = {
              name = "Adwaita Sans";
              package = pkgs.adwaita-fonts;
            };
            sansSerif = {
              name = "Adwaita Sans";
              package = pkgs.adwaita-fonts;
            };
            monospace = {
              name = "JetBrainsMono Nerd Font Mono";
              package = pkgs.nerd-fonts.jetbrains-mono;
            };
            emoji = {
              package = pkgs.noto-fonts-color-emoji;
              name = "Noto Color Emoji";
            };
            sizes = {
              terminal = 11;
            };
          };

          opacity.terminal = 0.4;

          targets = {
            gtk.enable = true;
            qt.enable = true;
            gnome.enable = lib.elem "gdm" host.activeAspects;
            regreet.enable = config.programs.regreet.enable;
          };
        };

        qt.style = lib.mkForce "adwaita-dark";
      };

    homeManager =
      {
        config,
        lib,
        user,
        ...
      }:
      {
        stylix = {
          targets = {
            gtk = {
              enable = true;
              flatpakSupport.enable = true;
              # Force dialog buttons to use white text
              extraCss = ''
                dialog button, .dialog-action-area > .text-button {
                  color: @theme_text_color; 
                }
              '';
            };

            kitty.enable = lib.elem "kitty" user.activeAspects;
            btop.enable = config.programs.btop.enable;
            qt.enable = true;
            qt.standardDialogs = "xdgdesktopportal";
            kde.enable = true;
          };
        };

        xdg.configFile.kdeglobals.source =
          let
            themePackage = lib.head (
              lib.filter (p: lib.match ".*stylix-kde-theme.*" (lib.baseNameOf p) != null) config.home.packages
            );
            colorSchemeSlug = lib.concatStrings (
              lib.filter lib.isString (lib.split "[^a-zA-Z]" config.lib.stylix.colors.scheme)
            );
          in
          "${themePackage}/share/color-schemes/${colorSchemeSlug}.colors";

        qt.style.name = lib.mkForce "adwaita-dark";

        dconf.settings."org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
        };

        # Clean up dots
        xresources.path = "${config.xdg.configHome}/X11/xresources";
        home.sessionVariables = {
          XCOMPOSECACHE = "${config.xdg.cacheHome}/X11/xcompose";
        };
      };

    niri =
      { config, pkgs, ... }:
      {
        settings.spawn-at-startup = [
          { sh = "${pkgs.xrdb}/bin/xrdb -merge ${config.xresources.path}"; }
        ];
      };
  };
}
