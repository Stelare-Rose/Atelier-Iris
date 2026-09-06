{ config, pkgs, ctx, ...}@inputs:
let 
  # Unwrap ctx here
in
  {
  nixpkgs.config.allowUnfree = true;
  hardware.enableAllFirmware = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  imports = [
    ../modules/nixos
  ];

  modules.audio.enable = true;
  modules.desktop.enable = true;
  modules.virtualisation.enable = true;
  modules.user.enable = true;
  modules.boot.enable = true;

	system.stateVersion = "24.05"; 
}
