{ inputs, den, ... }: {
  den.aspects.cli = {
    includes = with den.aspects.cli.provides; [ eza ];
    
    provides.eza = {
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
  };
}
