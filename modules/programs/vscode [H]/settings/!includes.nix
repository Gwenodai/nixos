{ den, ... }: {
  den.aspects.vscode._.settings = {
    includes = with den.aspects.vscode._.settings._; [
      fonts
      formatting
      general
      source-control
      terminal
      ui
    ];
  };
}
