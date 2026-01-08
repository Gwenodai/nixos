{
  inputs,
  self,
  ...
}:

let
  username = "gwen";

  flake.modules.nixos."${username}" = {
    config,
    pkgs,
    ...
  }:

  {
    imports = with inputs.self.modules.nixos; [
      # TODO: Define more nix modules to load here
    ];

    home-manager.users."${username}" = {
      imports = [
        inputs.self.modules.homeManager."${username}"
      ];
    };

    users.users."${username}" = {
      isNormalUser = true;
      initialPassword = "changeme";
      shell = pkgs.zsh;
    };
    programs.zsh.enable = true;
  };
in
{
  inherit flake;
}