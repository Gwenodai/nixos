# it87 driver with support for newer IT86xx/IT87xx chips
{ inputs, ... }: {
  # Flake inputs
  flake-file.inputs.it87 = {
    url = "github:frankcrawford/it87";
    flake = false;
  };

  den.aspects.kernel.provides.modules = {
    provides.it87 = {
      nixos = { config, pkgs, ... }: {
        boot.extraModulePackages = let
          it87-driver = config.boot.kernelPackages.callPackage (
            { stdenv, kernel }: stdenv.mkDerivation {
              pname = "it87";
              version = "master-${inputs.it87.shortRev or "dirty"}";
              src = inputs.it87;

              # Hardening must be disabled for the following to build the kernel module
              hardeningDisable = [
                "pic"
                "format"
              ];

              nativeBuildInputs = kernel.moduleBuildDependencies;

              # Invoke the kernel build system directly pointing to the current dir
              # bypassing the default parsing logic of the included makefile
              buildPhase = ''
                runHook preBuild
                make -C ${kernel.dev}/lib/modules/${kernel.modDirVersion}/build M=$(pwd) modules
                runHook postBuild
              '';

              # Manually install the driver because 'make modules_install' 
              # tries to write to /lib/modules and run depmod
              installPhase = ''
                install -D it87.ko $out/lib/modules/${kernel.modDirVersion}/kernel/drivers/hwmon/it87.ko
              '';
            }
          ) {};
        in [ it87-driver ];

        boot.kernelModules = [ "it87" ];
      };
    };
  };
}