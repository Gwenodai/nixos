{ den, ... }:
{
  den.aspects.vscode.includes = with den.aspects.vscode._; [
    enable
    settings
    languages
    extensions
    themes._.default
  ];
}
