{ config, ctx, nixcfg, pkgs, lib, ... }:
let
  cfg = config.home.quickshell;
  inputs = ctx.inputs;
in
{
  options.home.quickshell.enable = lib.mkOption {
    type = lib.types.bool;
    default = nixcfg.modules.desktop.niri.enable;
    description = "Enables Quickshell with Atelier Camelia";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      inputs.quickshell.packages.${pkgs.system}.default
    ];

    xdg.configFile."quickshell".source = inputs.atelier-camelia;
  };
}
