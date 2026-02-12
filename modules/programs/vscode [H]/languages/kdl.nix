{ ... }: {
  # --- HOME MANAGER MODULE ---
  flake.modules.homeManager.vscode = {
    pkgs,
    ...
  }: {
    programs.vscode = {
      profiles.default = {
        extensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "kdl";
            publisher = "kdl-org";
            version = "2.1.3";
            sha256 = "sha256-Jssmb5owrgNWlmLFSKCgqMJKp3sPpOrlEUBwzZSSpbM=";
          }
        ];
      };
    };
  };
}