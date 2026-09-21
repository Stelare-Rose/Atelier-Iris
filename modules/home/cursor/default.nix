{ config, nixcfg, lib, pkgs, ctx, ... }:
let
  cfg = config.home.cursor;
  inputs = ctx.inputs;
in
  {
  options.home.cursor.enable = lib.mkOption {
    type = lib.types.bool;
    default = nixcfg.modules.desktop.enable;
    description = "Enables custom cursor";
  };
  config = lib.mkIf cfg.enable {
    home.pointerCursor = {
      package = inputs.cursor.packages.${pkgs.stdenv.hostPlatform.system}.default;
      name = "StarryCursor";
      size = 24;
    };
  };
}
