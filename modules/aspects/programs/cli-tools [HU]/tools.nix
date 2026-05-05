{ den, ... }:
let
  tools = den.lib.perHost {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          # ---Archive Tools--- #
          zip # Compressor/archiver for creating and modifying zip files
          unzip # Extraction utility for archives compressed in .zip format
          xz # General-purpose data compression software, successor of LZMA
          p7zip # 7-Zip file archiver linux port with additional codecs and improvements
          gnutar # GNU implementation of the 'tar' archiver

          # ---CLI Tools--- #
          parted # CLI program for creating and manipulating partition tables
          file # Program that shows the type of files
          tree # Command to produce a depth indented directory listing
          which # Shows the full path of (shell) commands
          wget # Tool for retrieving files using HTTP, HTTPS, and FTP
          curl # Command line tool for transferring files with URL syntax
          gnused # GNU sed, a batch stream editor
          gawk # GNU implementation of the Awk programming language
          jq # Lightweight and flexible command-line JSON processor

          # ---System Tools--- #
          iotop # Real-time I/O monitor
          iftop # Display bandwidth usage on an interface by host
          strace # System call tracer for Linux
          ltrace # Library call tracer
          lsof # Tool to list open files
        ];
      };
  };
in
{
  den.aspects.cli.includes = [
    tools
  ];
}
