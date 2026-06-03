{ den, ... }:
let
  enable = {
    homeManager =
      { pkgs, ... }:
      {
        programs.bat = {
          enable = true;
          config.theme = "Monokai Extended";

          extraPackages = with pkgs.bat-extras; [
            batman # Read system manual pages (man) using bat as the manual page formatter
            batgrep # Quickly search through and highlight files using ripgrep
            batdiff # Diff a file against the current git index, or display the diff between two files
            batpipe # Less (and soon bat) preprocessor for viewing more types of files in the terminal
            batwatch # Watch for changes in one or more files, and print them with bat
            prettybat # Pretty-print source code
          ];
        };
      };

    persistUserIgnore =
      { hmConfig, ... }:
      {
        directories = [ "${hmConfig.xdg.cacheHome}/bat" ];
        files = [ "${hmConfig.xdg.stateHome}/lesshst" ];
      };
  };

  aliases = {
    homeManager = {
      # Custom aliases
      home.shellAliases = {
        cat = "bat";
        man = "batman";
        # Make batgrep properly scale to terminal width
        grep = "batgrep --terminal-width=$(( $(echo $COLUMNS) - 8 ))";
        diff = "batdiff";
        less = "batpipe";
        watch = "batwatch";
      };
    };
  };
in
{
  den.aspects.cli.includes = [
    enable
    aliases
  ];
}
