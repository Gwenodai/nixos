{
  den.aspects.cli = {
    provides.nixos-pkgs = {
      nixos = { pkgs, ... }: {
        environment.systemPackages = with pkgs; [
          parted # CLI program for creating and manipulating partition tables
          file   # Program that shows the type of files
          tree   # Command to produce a depth indented directory listing
          which  # Shows the full path of (shell) commands
          wget   # Tool for retrieving files using HTTP, HTTPS, and FTP
          curl   # Command line tool for transferring files with URL syntax
          gnused # GNU sed, a batch stream editor
          gawk   # GNU implementation of the Awk programming language
          jq     # Lightweight and flexible command-line JSON processor
        ];
      };
    };
  };
}
