{
  den.aspects.cli-tools = {
    homeManager = {
      # TODO: Configure eza
      programs.eza = {
        enable = true;
        enableBashIntegration = false;
        enableZshIntegration = false;
        icons = "always";
        git = true;
        extraOptions = [
          "--group-directories-first"
          "--header"
        ];
      };

      ### Aliases
      home.shellAliases = {
        ll = "eza";
      };
    };
  };
}
