{ inputs, den, ... }: {
  den.aspects.vscode._.settings._.terminal = den.lib.perUser {
    homeManager = { pkgs, lib, ... }: {
      programs.vscode.profiles.default.userSettings.terminal = {
        external.linuxExec = lib.mkDefault "${lib.getExe pkgs.kitty}";

        integrated = inputs.self.lib.applyDefaults {
          defaultProfile.linux = "zsh";
          cursorBlinking = true;
          cursorStyle = "line";
          smoothScrolling = true;
        };
      };
    };
  };
}
