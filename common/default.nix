{ config, pkgs, ctx, lib, ...}@inputs:
let 
  # Unwrap ctx here
in
  {
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.kernelPackages = lib.mkDefault pkgs.linuxKernel.packages.linux_7_2;

  imports = [
    ../modules/nixos
  ];

  modules.audio.enable = lib.mkDefault true;
  modules.desktop.enable = lib.mkDefault true;
  modules.virtualisation.enable = lib.mkDefault true;
  modules.user.enable = lib.mkDefault true;
  modules.boot.enable = lib.mkDefault true;

  time.timeZone = lib.mkDefault "Asia/Jakarta";
  i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";
	system.stateVersion = "24.05"; 
}
