{ lib, ... }:
{
  services.syncthing = {
    group = "users";
    guiAddress = "0.0.0.0:8384";
    dataDir = lib.mkForce "/home/shared/sync/";
    configDir = "/home/shared/.config/syncthing";
  };
}
