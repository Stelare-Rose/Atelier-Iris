{ pkgs, lib, ... }:
{
  systemd.services.cae = {
    enable = lib.mkDefault false;
    serviceConfig = { Restart = "always"; RuntimeMaxSec = "1d"; };
    wantedBy = [ "multi-user.target" ];
    script = ''
      cd /home/shared/minecraft/Create-Arcane-Engineering
      ./start.sh
    '';
    path = with pkgs; [ temurin-bin-17 bash ];
  };
}
