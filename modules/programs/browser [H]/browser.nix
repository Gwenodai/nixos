{
  flake.modules.homeManager.browser = {
    pkgs,
    ...
  }:

  {
    home.packages = with pkgs; [
      google-chrome
    ];
  };
}