{ lib, config, ... }:
{
  imports = [
    ../../common/default.nix
  ];
  modules = {
    communication.enable = false;
    creative.enable = false;
    constellation.enable = false;
    development.enable = false;
    downloaders.enable = false;
    gaming.enable = false;
    media.production.enable = false;
    office.enable = false;
    virtualisation.enable = false;
    wireguard.enable = false;
    user.extraImports = [ ./users/stelare.nix ];
  };

  virtualisation.vmVariant.virtualisation.sharedDirectories.atelier = {
    source = config.iris.repoPath;
    target = "/home/Stelare/Atelier-Iris";
  };
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
