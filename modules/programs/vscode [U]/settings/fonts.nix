{ inputs, den, ... }: {
  den.aspects.vscode._.settings._.fonts = den.lib.perUser {
    nixos = { pkgs, ... }: {
      # Make sure "JetBrainsMono Nerd Font" is available
      fonts.packages = with pkgs.nerd-fonts; [ jetbrains-mono ];
    };
    
    homeManager = { lib, ... }: {
      programs.vscode.profiles.default = {
        userSettings = inputs.self.lib.applyDefaultsRecursive {
          editor = {
            # Single quotes are required for font names with spaces
            fontFamily = lib.concatStringsSep ", " [
              "'JetBrainsMono Nerd Font'"
              "'Droid Sans Mono'"
              "monospace"
            ];
            # Combines multiple characters '!'+'='becomes '≠'
            fontLigatures = true;
          };
        };
      };
    };

    persistUserIgnore = { hmConfig, ... }: {
      directories = [ "${hmConfig.xdg.cacheHome}/fontconfig" ];
    };
  };
}
