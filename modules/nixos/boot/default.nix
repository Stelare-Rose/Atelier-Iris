{ config, lib, pkgs, ... }:
let 
  cfg = config.modules.boot;
in
{
  options.modules.boot.enable = lib.mkEnableOption "enables bootloader (GRUB)";
  config = lib.mkIf cfg.enable {
    boot.loader = {
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot/efi";
      timeout = 30;
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        useOSProber = true;
        theme = (pkgs.catppuccin-grub.override {flavor = "latte";});
      };
    }; 
  };
}
