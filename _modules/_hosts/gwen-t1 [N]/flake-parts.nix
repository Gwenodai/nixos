# Create the host system using our 'mkNixos' function
{
  inputs,
  ...
}: {
  # Pass 'mkNixos' the system type and host name to construct the system
  flake.nixosConfigurations = inputs.self.lib.mkNixos "x86_64-linux" "gwen-t1";
}