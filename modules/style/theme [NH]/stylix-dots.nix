# Clean up some dotfiles stylix created
# Not all dotfiles can be moved out of the root home dir unfortunately
{
  inputs,
  ...
}: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.theme = {
    options,
    config,
    pkgs,
    lib,
    ...
  }: lib.mkMerge [
    {
      xresources.path = lib.mkDefault "${config.xdg.configHome}/X11/xresources";
      home.sessionVariables = {
        XCOMPOSECACHE = lib.mkDefault "${config.xdg.cacheHome}/X11/xcompose";
      };
    }
    (
      inputs.self.lib.mkIfNiri { inherit options; } {
        programs.niri.settings.spawn-at-startup = [
          { sh = "${pkgs.xorg.xrdb}/bin/xrdb -merge ${config.xresources.path}"; }
        ];
      }
    )
  ];
}