{ config, lib, pkgs, ctx, ... }:
let
  cfg = config.modules.communication;
  unstable = ctx.unstable;
in
  {
  options.modules.communication.enable = lib.mkEnableOption "packages often used for communication";
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      vesktop
      unstable.zoom-us
    ];
  };
}
