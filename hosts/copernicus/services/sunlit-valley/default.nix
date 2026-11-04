{ pkgs, lib, ... }:
{
  systemd.services.sunlit = {
    enable = lib.mkDefault false;
    serviceConfig = { Restart = "always"; RuntimeMaxSec = "1d"; };
    wantedBy = [ "multi-user.target" ];
    script = ''
      cd /home/shared/minecraft/Sunlit-Valley
      ./start.sh
    '';
    path = with pkgs; [ temurin-bin-17 bash ];
  };
}
