# Outputs a boilerplate user config
{
  self,
  ...
}: {
  # --- FACTORY ASPECT ---
  config.flake.factory.user = username: isAdmin: {

    # Creates a nixos module
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
      
      # Import the Home Manager module automatically
      home-manager.users."${username}" = {
        imports = [
          self.modules.homeManager."${username}"
        ];
      };
    };

    # Creates a Home Manager module
    homeManager."${username}" = {
      home.username = "${username}";
    };
  };
}