{ config, lib, pkgs, ctx, ... }:
let
  cfg = config.modules.constellation;
  inputs = ctx.inputs;
in
  {
  # Note: This part of the moduleset is unstable, and may change due to implementation details in the underlying apps.
  options.modules.constellation.enable = lib.mkEnableOption "the constellation apps";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with inputs; [
      self.packages.${pkgs.stdenv.hostPlatform.system}.pyxis
      horologium.packages.${pkgs.stdenv.hostPlatform.system}.horologium-cli
    ];
  };
}
  
