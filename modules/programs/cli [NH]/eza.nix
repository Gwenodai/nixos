{ inputs,... }: {
  den.aspects.cli = {
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
