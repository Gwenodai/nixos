{ inputs, ... }: {
  perSystem = { pkgs, self', lib, ... }: let
    checkCond = name: cond: pkgs.runCommandLocal name { } (if cond then "touch $out" else "");
    gwen-t1 = inputs.self.nixosConfigurations.gwen-t1.config;
    vmBuilds = !pkgs.stdenvNoCC.isLinux || lib.pathExists (self'.packages.vm + "/bin/vm");
    gwen-t1Builds = !pkgs.stdenvNoCC.isLinux || lib.pathExists (gwen-t1.system.build.toplevel);
  in {
    # checks."gwen-t1 builds" = checkCond "gwen-t1-builds" gwen-t1Builds;
    # checks."vm builds" = checkCond "vm-builds" vmBuilds;
    # checks."gwen enabled gwen-t1 nh" = checkCond "gwen._.gwen-t1" gwen-t1.programs.nh.enable;
  };
}
