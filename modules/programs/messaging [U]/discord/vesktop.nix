{ inputs, den, ... }: {
  den.aspects.messaging._.discord = {
    includes = with den.aspects.messaging._.discord._; [ vesktop ];
    
    # https://mynixos.com/home-manager/options/programs.vesktop
    _.vesktop = den.lib.perUser {
      homeManager = { pkgs, lib, ... }: {
        programs.vesktop = lib.mkDefault {
          enable = true;

          settings = {
            appBadge = true;
            arRPC = true;
            checkUpdates = false;
            SKIP_HOST_UPDATE = true;
            customTitleBar = false;
            disableMinSize = true;
            tray = true;
            minimizeToTray = true;
            splashTheming = true;
            staticTitle = false;
            hardwareAcceleration = true;
            hardwareVideoAcceleration = true;
            discordBranch = "stable";
            spellCheckLanguages = [
              "en-GB"
              "en-AU"
              "en"
            ];
          };

          vencord = {
            settings = {
              # Update settings
              autoUpdate = true;
              autoUpdateNotification = false;
              notifyAboutUpdates = false;
              # Window Settings
              disableMinSize = true;
              frameless = true;
              # Theming
              themeLinks = [
                "https://luckfire.github.io/amoled-cord/src/amoled-cord.css"
              ];

              # Plugins
              plugins = {
                CrashHandler.enabled = true;
                WebScreenShareFixes.enabled = true;
                WebKeybinds.enabled = true;
                AlwaysTrust.enabled = true;
                BiggerStreamPreview.enabled = true;
                FixSpotifyEmbeds.enabled = true;
                ImageZoom.enabled = true;
                PlatformIndicators.enabled = true;
                PreviewMessage.enabled = true;
                ShowHiddenChannels.enabled = true;
                SilentMessageToggle.enabled = true;
                TypingIndicator.enabled = true;
                TypingTweaks.enabled = true;
                UserVoiceShow.enabled = true;
                VolumeBooster.enabled = true;
                FixImagesQuality.enabled = true;

                ShikiCodeblocks = {
                  enabled = true;
                  theme = "https://raw.githubusercontent.com/millsp/material-candy/master/material-candy.json";
                };

                CustomIdle = {
                  enabled = true;
                  idleTimeout = 3;
                  remainInIdle = false;
                };

                BetterFolders = {
                  enabled = true;
                  sidebar = true;
                };

                MessageLogger = {
                  enabled = true;
                  ignoreSelf = true;
                };
                
                FakeNitro = {
                  enabled = true;
                  enableStreamQualityBypass = true;
                  enableEmojiBypass = false;
                  transformEmojis = false;
                  enableStickerBypass = false;
                  transformStickers = false;
                  transformCompoundSentence = false;
                  useHyperLinks = false;
                  disableEmbedPermissionCheck = false;
                };
              };
            };
          };
        };

        services.arrpc = inputs.self.lib.applyDefaults {
          enable = true;
          package = pkgs.arrpc;
          systemdTarget = "graphical-session.target";
        };

        # Autostart
        xdg.configFile."autostart/vesktop.desktop" = lib.mkDefault {
          text = ''
            [Desktop Entry]
            NotShowIn=niri
            Categories=Network;InstantMessaging;Chat
            Exec=vesktop --start-minimized
            GenericName=Internet Messenger
            Icon=vesktop
            Keywords=discord;vencord;electron;chat
            Name=Vesktop
            StartupWMClass=Vesktop
            Type=Application
            Version=1.5
          '';
        };
      };

      persistUser = { hmConfig, ... }: {
        directories = [
          {
            directory = "${hmConfig.xdg.configHome}/vesktop/sessionData";
            how = "symlink";
            mode = "0700";
            createLinkTarget = true;
          }
        ];
        files = [
          { file = "${hmConfig.xdg.configHome}/vesktop/Crashpad/client_id"; mode = "0644"; }
          { file = "${hmConfig.xdg.configHome}/vesktop/state.json"; mode = "0644"; }
        ];
      };

      persistUserTmp = { hmConfig, ... }: {
        "${hmConfig.xdg.configHome}" = {}; # "~/.config"
        "${hmConfig.xdg.configHome}/vesktop" = {};
        "${hmConfig.xdg.configHome}/vesktop/Crashpad" = { mode = "0700"; };
        "${hmConfig.xdg.configHome}/vesktop/sessionData" = { mode = "0700"; };
      };

      persistUserIgnore = { hmConfig, ... }: {
        files = [ "${hmConfig.xdg.configHome}/vesktop/settings/quickCss.css" ];
      };
    };
  };
}
