{
    config,
    ...
}:

let
  username = "gwen";
in {
  # Define the NixOS system user
  users.users.${username} = {
    isNormalUser = true;
    description = "Gwendolyn Park";
    extraGroups = [ 
        "wheel"
        "networkmanager"
    ];
  };
  # Ensure user group exists
  users.groups.${username} = {};

  # Home Manager config for this user
  home-manager.users.${username} = {
    imports = [ ./home.nix ];
    _module.args.username = username;
  };
}