# https://mynixos.com/home-manager/options/programs.vesktop
{
  inputs,
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.discord = {
    pkgs,
    lib,
    ...
  }: {
    programs.vesktop = lib.mkDefault {
      enable = true;

      settings = {
        appBadge = true;
        arRPC = true;
        checkUpdates = false;
        SKIP_HOST_UPDATE = true;
        customTitleBar = false;
        disableMinSize = true;
        minimizeToTray = true;
        tray = true;
        splashBackground = "#000000";
        splashColor = "#ffffff";
        splashTheming = true;
        staticTitle = true;
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
          autoUpdate = false;
          autoUpdateNotification = false;
          notifyAboutUpdates = false;
          # Window Settings
          disableMinSize = true;
          frameless = true;
          winNativeTitleBar = false;
          # Theming
          useQuickCss = true;
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

    # Autostart after login
    systemd.user.services.vesktop = lib.mkDefault {
      Install.WantedBy = [ "graphical-session.target" ];
      
      Service = {
        ExecStartPre = "${pkgs.coreutils}/bin/sleep 5"; # Delay for system tray
        ExecStart = "${lib.getExe pkgs.vesktop} --start-minimized";
        Restart = "on-failure";
        RestartSec = 3;
      };

      Unit = {
        Description = "Vesktop Discord Client";
        After = [ "graphical-session.target" ];
        X-SwitchMethod = "keep-old";
      };
    };
  };
}