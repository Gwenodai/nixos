# Simple script to disable faulty webcam autofocus functionality
{
  den.aspects.fix-camera = {
    nixos =
      { pkgs, lib, ... }:
      let
        fixCam = pkgs.writeShellApplication {
          name = "fix-camera";
          runtimeInputs = [ pkgs.v4l-utils ];
          text = lib.replaceStrings [ "# syntax: bash\n" ] [ "" ] ''
            # syntax: bash
            v4l2-ctl -c focus_automatic_continuous=0
            v4l2-ctl -c focus_absolute=0
          '';
        };
      in
      {
        environment.systemPackages = [ fixCam ];
      };
  };
}
