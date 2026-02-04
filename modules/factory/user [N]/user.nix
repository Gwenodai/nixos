# Outputs a boilerplate user config
{
  self,
  ...
}: {
  # --- FACTORY ASPECT ---
  config.flake.factory.user = username: isAdmin: {

    nixos."${username}" = {
      lib,
      pkgs,
      ...
    }: {
      users.users."${username}" = {
        isNormalUser = true;
        home = "/home/${username}";
        extraGroups = lib.optionals isAdmin [
          "wheel"
          "networkmanager"
        ];
        shell = pkgs.zsh;
      };
      programs.zsh.enable = true;

      home-manager.users."${username}" = {
        imports = [
          self.modules.homeManager."${username}"
        ];
      };
    };

    homeManager."${username}" = {
      home.username = "${username}";
    };
  };
}