{ inputs, ... }: {
  den.aspects.shell = {
    # https://mynixos.com/home-manager/options/programs.zsh
    provides.zsh = {
      homeManager = { config, lib, ... }: {
        programs.zsh = {
          enable = lib.mkDefault true;
          dotDir = lib.mkDefault "${config.xdg.configHome}/zsh";
          enableCompletion = lib.mkDefault true;
          history = inputs.self.lib.applyDefaults {
            size = 1000000000;
            save = 1000000000;
            # Both imports new commands from the history file, and also 
            # causes your typed commands to be appended to the history file
            share = true;
            # zsh sessions will append their history list to the history file, rather than replace it
            append = true;
            # Do not enter command lines into the history list if they are duplicates of the previous event
            ignoreDups = true;
            # Do not enter command lines into the history list if the first character is a space
            ignoreSpace = true;
          };
          autosuggestion = {
            enable = lib.mkDefault true;
            strategy = lib.mkDefault [
              "match_prev_cmd"
              "completion"
            ];
          };
          syntaxHighlighting = {
            enable = lib.mkDefault true;
          };
          setOptions = lib.mkDefault [
            # Force Zsh to write directly into the existing file
            "NO_HIST_SAVE_BY_COPY"
            # Don't beep on error
            "NO_BEEP"
            # Allow comments even in interactive shells
            "INTERACTIVE_COMMENTS"
          ];
        };
      };

      persistUser = { hmConfig, ... }: {
        files = [
          {
            file = "${hmConfig.xdg.configHome}/zsh/.zsh_history";
            mode = "0600";
          }
        ];
      };

      persistUserTmp = { hmConfig, ... }: {
        "${hmConfig.xdg.configHome}" = {}; # "~/.config"
        "${hmConfig.xdg.configHome}/zsh" = {};
      };

      persistUserIgnore = { hmConfig, ... }: {
        files = [ "${hmConfig.xdg.configHome}/zsh/.zcompdump" ];
      };
    };
  };
}
