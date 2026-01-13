{
  flake.modules.nixos.archive-tools = {
    pkgs,
    ...
  }: {
    environment.systemPackages = with pkgs; [
      zip # Compressor/archiver for creating and modifying zipfiles
      unzip # Extraction utility for archives compressed in .zip format
      xz # General-purpose data compression software, successor of LZMA
      p7zip # 7-Zip file archiver linux port with additional codecs and improvements
      gnutar # GNU implementation of the `tar' archiver
    ];
  };
}