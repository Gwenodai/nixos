{ den, ... }:
{
  den.aspects.cli._.tools._.sys-tools = den.lib.perHost {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          iotop # Real-time I/O monitor
          iftop # Display bandwidth usage on an interface by host
          strace # System call tracer for Linux
          ltrace # Library call tracer
          lsof # Tool to list open files
        ];
      };
  };
}
