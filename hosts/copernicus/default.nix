{ ctx, ... }:
let
  inputs = ctx.inputs;
  root = ctx.root;
in
  {
  imports = [
    ../../common/default.nix
    ./hardware.nix
    ./services
  ];
  networking.hostName = "Copernicus"; 
  sops.age.keyFile = "/home/Stelare/.config/sops/age/keys.txt";
  modules = {
    audio.enable = false;
    browser.enable = false;
    communication.enable = false;
    creative.enable = false;
    desktop.enable = false;
    desktop.hyprland.enable = false;
    desktop.niri.enable = false;
    fonts.enable = false;
    gaming.enable = false;
    media.viewing.enable = false;
    media.production.enable = false;
    obs.enable = false;
    office.enable = false;
    utils.gui.enable = false;
    user.extraImports = [ ./users/stelare.nix ];
  };
  users.users.Stelare.openssh.authorizedKeys.keyFiles = [
    (root + /keys/Selene.pub)
    (root + /keys/Crescent.pub)
    (root + /keys/Nocturne.pub)
  ];

  boot.loader.systemd-boot.enable = true;

  networking.firewall.allowedTCPPorts = [ 22 111 2049 3000 5000 8384 22000 25565 25566 ];
  networking.firewall.allowedUDPPorts = [ 22 5000 21027 22000 24454 25565 25566 ];

  systemd.services = {
    quacks.enable = false;
    cae.enable = false;
    StarT.enable = false;
    sunlit.enable = false;
  };
}
