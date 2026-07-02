{
  den.aspects.razer = {
    nixos = { pkgs, ... }: {
      hardware.openrazer.enable = true;
      environment.systemPackages = with pkgs; [
        openrazer-daemon
        polychromatic
      ];
    };

    user.extraGroups = [ "openrazer" ];
  };
}
