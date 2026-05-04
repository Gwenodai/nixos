{ den, ... }:
{
  # https://mynixos.com/home-manager/options/programs.zsh
  den.aspects.shell._.zsh._.config = den.lib.perUser {
    homeManager =
      { config, lib, ... }:
      {
        programs.zsh = {
          enableCompletion = lib.mkDefault true;
          history = {
            size = lib.mkDefault 1000000000;
            save = lib.mkDefault 1000000000;
            # Both imports new commands from the history file, and also
            # causes your typed commands to be appended to the history file
            share = lib.mkDefault true;
            # zsh sessions will append their history list to the history file, rather than replace it
            append = lib.mkDefault true;
            # Do not enter command lines into the history list if they are duplicates of the previous event
            ignoreDups = lib.mkDefault true;
            # Do not enter command lines into the history list if the first character is a space
            ignoreSpace = lib.mkDefault true;
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
  };
}
