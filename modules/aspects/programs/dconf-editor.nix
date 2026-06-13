{
  den.aspects.dconf-editor = {
    homeManager =
      { pkgs, lib, ... }:
      {
        home.packages = with pkgs; [
          dconf-editor # Tool for easily viewing dconf settings
        ];

        dconf.settings."ca/desrt/dconf-editor" = lib.mkDefault {
          show-warning = false;
        };
      };
  };
}
