{ pkgs, lib, ... }:
{
  systemd.services.quacks = {
    enable = lib.mkDefault false;
    serviceConfig = { Restart = "always"; RuntimeMaxSec = "1d"; };
    wantedBy = [ "multi-user.target" ];
    script = ''
      cd /home/shared/minecraft/quacks
      ./start_server.bat
    '';
    path = with pkgs; [ openjdk17-bootstrap git git-lfs ];
  };
}
