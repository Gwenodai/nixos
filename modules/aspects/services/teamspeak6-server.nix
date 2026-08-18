# Native systemd service for hosting a TeamSpeak 6 server on NixOS
{ inputs, ... }:
{
  flake-file.inputs.teamspeak6-server = {
    url = "https://github.com/teamspeak/teamspeak6-server/releases/latest/download/teamspeak6-server-linux-amd64.tar.xz";
    flake = false;
  };

  den.aspects.teamspeak6-server = {
    nixos =
      { pkgs, ... }:
      let
        ts6-server = pkgs.stdenvNoCC.mkDerivation {
          pname = "teamspeak6-server";
          version = "latest";
          src = inputs.teamspeak6-server;
          sourceRoot = "source";

          nativeBuildInputs = with pkgs; [
            autoPatchelfHook
            makeWrapper
          ];

          buildInputs = with pkgs; [
            stdenv.cc.cc.lib
          ];

          dontConfigure = true;
          dontBuild = true;

          installPhase = ''
            runHook preInstall

            mkdir -p $out/libexec/teamspeak6 $out/bin
            cp -a ./. $out/libexec/teamspeak6/

            chmod +x $out/libexec/teamspeak6/tsserver

            makeWrapper $out/libexec/teamspeak6/tsserver $out/bin/tsserver

            runHook postInstall
          '';
        };
      in
      {
        users.groups.teamspeak6 = { };
        users.users.teamspeak6 = {
          description = "TeamSpeak 6 server";
          isSystemUser = true;
          group = "teamspeak6";
          home = "/var/lib/teamspeak6";
          createHome = true;
        };

        systemd.tmpfiles.rules = [
          "d /var/lib/teamspeak6 0750 teamspeak6 teamspeak6 - -"
        ];

        networking.firewall.allowedUDPPorts = [ 9987 ];
        networking.firewall.allowedTCPPorts = [ 30033 ];

        systemd.services.teamspeak6-server = {
          description = "TeamSpeak 6 server";
          after = [ "network-online.target" ];
          wants = [ "network-online.target" ];
          wantedBy = [ "multi-user.target" ];
          serviceConfig = {
            Type = "simple";
            User = "teamspeak6";
            Group = "teamspeak6";
            WorkingDirectory = "/var/lib/teamspeak6";
            Environment = "TSSERVER_LICENSE_ACCEPTED=accept";
            ExecStart = ''
              ${ts6-server}/bin/tsserver \
                --db-sql-path ${ts6-server}/libexec/teamspeak6/sql \
                --db-sql-create-path create_sqlite
            '';
            Restart = "on-failure";
            RestartSec = "5s";
            NoNewPrivileges = true;
            PrivateTmp = true;
            ProtectSystem = "strict";
            ProtectHome = true;
            ReadWritePaths = [ "/var/lib/teamspeak6" ];
          };
        };
      };

    ### Persist config
    persist = {
      directories = [
        {
          directory = "/var/lib/teamspeak6";
          mode = "0750";
          how = "symlink";
          createLinkTarget = true;
        }
      ];
    };
  };
}
