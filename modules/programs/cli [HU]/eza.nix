{ inputs, den, ... }: {
  den.aspects.cli._.eza = den.lib.perUser {
    homeManager = { lib, ... }: {
      # TODO: Configure eza
      programs.eza = inputs.self.lib.applyDefaults {
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
