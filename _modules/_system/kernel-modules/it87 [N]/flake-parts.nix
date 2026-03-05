# it87 driver with support for newer IT86xx/IT87xx chips
{
  ...
}: {
  flake-file.inputs = {
    it87 = {
      url = "github:frankcrawford/it87";
      flake = false;
    };
  };
}