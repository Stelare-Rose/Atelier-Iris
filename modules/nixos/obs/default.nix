{ config, lib, pkgs, ... }:
let
  cfg = config.modules.obs;
in
  {
  options.modules.obs.enable = lib.mkEnableOption "obs";
  options.modules.obs.droidcam.enable = lib.mkEnableOption "droidcam support (Requires Restart)";
  config = lib.mkMerge [
    { 
      warnings = lib.optional (!cfg.enable && cfg.droidcam.enable) 
        "Droidcam module for obs is enabled however the obs module itself is disabled. This may not work as expected";
    }
    (lib.mkIf cfg.enable {
      programs.obs-studio = {
        enable = true;
        enableVirtualCamera = true;

      };
    })
    (lib.mkIf cfg.droidcam.enable {
      programs.obs-studio.plugins = with pkgs.obs-studio-plugins; [
        droidcam-obs
      ];
      boot.extraModulePackages = with config.boot.kernelPackages; [v4l2loopback];
      boot.kernelModules = ["v4l2loopback"];
    })
  ];
}
