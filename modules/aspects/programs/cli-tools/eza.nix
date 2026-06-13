{
  den.aspects.cli-tools = {
    homeManager = {
      # TODO: Configure eza
      programs.eza = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
        icons = "always";
        git = true;
        extraOptions = [
          "--group-directories-first"
          "--header"
        ];
      };
    };
  };
}
