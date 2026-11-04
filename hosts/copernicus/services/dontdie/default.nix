{ pkgs, ... }:
{
  systemd.services.dontdie = {
    enable = true;
    serviceConfig = { Restart = "always"; RuntimeMaxSec = "1d"; };
    wantedBy = [ "multi-user.target" ];
    script = ''
      cd /home/shared/dontdie
      ./run.sh
    '';
    path = with pkgs; [ bun bash ];
  };
}
