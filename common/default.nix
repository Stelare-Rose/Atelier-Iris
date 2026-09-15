{ config, pkgs, ctx, lib, ...}@inputs:
let 
  # Unwrap ctx here
  root = ctx.root;
in
  {
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.kernelPackages = lib.mkDefault pkgs.linuxKernel.packages.linux_7_2;

  imports = [
    (root + /modules/nixos)
    ./virtual-default.nix
  ];

	services.xserver.xkb = lib.mkDefault {
		layout = "us";
		variant = "";
	};

  modules = {
    audio.enable = lib.mkDefault true;
    boot.enable = lib.mkDefault true;
    browser.enable = lib.mkDefault true;
    communication.enable = lib.mkDefault true;
    constellation.enable = lib.mkDefault true;
    creative.enable = lib.mkDefault true;
    desktop.enable = lib.mkDefault true;
    development.enable = lib.mkDefault true;
    downloaders.enable = lib.mkDefault true;
    fonts.enable = lib.mkDefault true;
    gaming.enable = lib.mkDefault true;
    media = {
      viewing.enable = lib.mkDefault true;
      production.enable = lib.mkDefault true;
    };
    networking.enable = lib.mkDefault true;
    nix-ld.enable = lib.mkDefault true;
    obs.enable = lib.mkDefault true;
    office.enable = lib.mkDefault true;
    shell.enable = lib.mkDefault true;
    user.enable = lib.mkDefault true;
    utils.enable = lib.mkDefault true;
    virtualisation.enable = lib.mkDefault true;
  };
    
  time.timeZone = lib.mkDefault "Asia/Jakarta";
  i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";
	system.stateVersion = "24.05"; 
}
