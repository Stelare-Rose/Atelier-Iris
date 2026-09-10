{ config, lib, pkgs, ... }:
let 
  cfg = config.modules.boot;
in
  {
  options.modules.boot.enable = lib.mkEnableOption "bootloader (GRUB)";
  config = lib.mkIf cfg.enable {
    systemd.services.plymouth-quit = {
      serviceConfig.ExecStart = lib.mkForce "${pkgs.plymouth}/bin/plymouth --wait quit";
    };
    boot = {
      plymouth = {
        enable = true;
        theme = "breeze"; # Placeholder, Custom in Progress
      };

      consoleLogLevel = 3;
      initrd = {
        systemd.enable = true;
        verbose = false;
      };
      kernelParams = [
        "quiet"
        "splash"
        "rd.udev.log_level=3"
        "rd.systemd.show_status=auto"
      ];
      loader = {
        efi.canTouchEfiVariables = true;
        efi.efiSysMountPoint = lib.mkIf (!config.virtualisation.useBootLoader) "/boot/efi";
        timeout = 0;
        grub = {
          enable = true;
          efiSupport = true;
          device = "nodev";
          useOSProber = true;
          theme = (pkgs.catppuccin-grub.override {flavor = "latte";});
          splashImage = null;
        };
      }; 
    };
  };
}
