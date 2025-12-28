{ ... }:

{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    # Custom Aliases
    shellAliases = {
      ll = "eza -Al --icons";
      ls = "eza -A --icons";
      cat = "bat";
    };
  };
}