{ pkgs, lib, ... }:
{
  systemd.services.StarT = {
    enable = lib.mkDefault false;
    serviceConfig = { Restart = "always"; RuntimeMaxSec = "1d"; };
    wantedBy = [ "multi-user.target" ];
    script = ''
      cd /home/shared/minecraft/Star-Technology
      ./run.sh
    '';
    path = with pkgs; [ temurin-bin-17 bash ];
  };
}
