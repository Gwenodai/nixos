{
  # Better cat with syntax highlighting
  flake.modules.homeManager.cli-tools = {
    pkgs,
    ...
  }: {
    programs.bat = {
      enable = true;
      config = {
        theme = "Monokai Extended";
      };
      extraPackages = with pkgs.bat-extras; [
        batman # Read system manual pages (man) using bat as the manual page formatter
        batgrep # Quickly search through and highlight files using ripgrep
        batdiff # Diff a file against the current git index, or display the diff between two files
        batpipe # Less (and soon bat) preprocessor for viewing more types of files in the terminal
        batwatch # Watch for changes in one or more files, and print them with bat
        prettybat # Pretty-print source code
      ];
    };

    # Custom aliases
    home.shellAliases = {
      cat = "bat";
      man = "batman";
      grep = "batgrep";
      diff = "batdiff";
      less = "batpipe";
      watch = "batwatch";
    };
  };
}