{ inputs, den, ... }: {
  # https://mynixos.com/home-manager/options/programs.vesktop
  den.aspects.messaging._.discord._.vesktop._.config = den.lib.perUser {
    homeManager = { pkgs, lib, ... }: {
      programs.vesktop = {
        settings = inputs.self.lib.applyDefaults {
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

        vencord.settings = {
          # Update settings
          autoUpdate = lib.mkDefault true;
          autoUpdateNotification = lib.mkDefault false;
          notifyAboutUpdates = lib.mkDefault false;
          # Window Settings
          disableMinSize = lib.mkDefault true;
          frameless = lib.mkDefault true;
          # Theming
          themeLinks = lib.mkDefault [
            "https://luckfire.github.io/amoled-cord/src/amoled-cord.css"
          ];

          # Plugins
          plugins = inputs.self.lib.applyDefaults {
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

      services.arrpc = lib.mkDefault {
        enable = true;
        systemdTarget = "graphical-session.target";
      };
    };
  };
}
