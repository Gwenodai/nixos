{ den, ... }: {
  den.aspects.vscode._.languages = {
    includes = with den.aspects.vscode._.languages._; [
      bash
      kdl
      nix
      toml
    ];
  };
}
