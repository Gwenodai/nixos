{
  # TODO: Configure zsh
  # https://mynixos.com/home-manager/options/programs.zsh
  flake.modules.homeManager.shell = {
    config,
    ...
  }: {
    programs.zsh = {
      enable = true;
      dotDir = "${config.xdg.configHome}/zsh";
      enableCompletion = true;
      history = {
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
        enable = true;
        strategy = [
          "match_prev_cmd"
          "completion"
        ];
      };
      syntaxHighlighting = {
        enable = true;
      };
      setOptions = [
        # Force Zsh to write directly into the existing file
        "NO_HIST_SAVE_BY_COPY"
        # Don't beep on error
        "NO_BEEP"
        # Allow comments even in interactive shells
        "INTERACTIVE_COMMENTS"
      ];
    };
  };
}