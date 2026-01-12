{
  inputs,
  ...
}: {
  flake.nixosConfigurations = inputs.self.lib.mkNixos "x86_64-linux" "gwen-t1";
}