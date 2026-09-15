{ lib, ... }:
{
  imports = [
    ../../common/default.nix
  ];
  modules = {
    communication.enable = false;
    creative.enable = false;
    development.enable = false;
    downloaders.enable = false;
    gaming.enable = false;
    media.production.enable = false;
    office.enable = false;
    virtualisation.enable = false;
    user.extraImports = [ ./users/stelare.nix ];
  };
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
