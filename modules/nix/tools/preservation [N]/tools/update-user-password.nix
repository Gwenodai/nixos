# Takes user input and writes a hashed password to `/persist/secrets/passwords/<USER>`
{
  flake.modules.nixos.preservation = {
    pkgs,
    lib,
    config,
    ...
  }: {
    config = lib.mkIf config.preservation.enable (
      let
        update-user-password = pkgs.writeShellApplication {
          name = "update-user-password";
          runtimeInputs = [
            pkgs.mkpasswd
            pkgs.doas
          ];
          text = ''
            TARGET_USER="$USER"

            if [ "$TARGET_USER" = "root" ]; then
              echo "Warning: You are running this as root."
              exit
            fi

            OUT_FILE="/persist/secrets/passwords/$TARGET_USER"

            echo "Preparing to update password for user: $TARGET_USER"
            echo "Output file: $OUT_FILE"
            echo

            while true; do
                read -r -s -p "Enter New User Password: " p1
                echo 
                read -r -s -p "Password (again): " p2
                echo

                if [[ "$p1" != "$p2" ]]; then
                    echo "Passwords do not match! Please try again."
                elif [[ -z "$p1" ]]; then
                    echo "Empty password. Please try again."
                else
                    break
                fi
            done

            HASH="$(mkpasswd -m sha-512 "$p1")"

            echo "Writing new password hash..."
            echo "$HASH" | doas tee "$OUT_FILE" > /dev/null
            echo
            echo "New password written to $OUT_FILE"
            echo "Password will become active next time you run:" 
            echo "sudo nixos-rebuild switch"
          '';
        };
      in {
        environment.systemPackages = [ update-user-password ];
      }
    );
  };
}