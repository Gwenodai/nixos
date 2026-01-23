{
  inputs,
  ...
}: {
  # Default settings needed for all Home-Manager configurations
  flake.modules.homeManager.system-default = {
    config,
    ...
  }: {
    home.homeDirectory = "/home/${config.home.username}";
    home.stateVersion = "25.11";
  };
}