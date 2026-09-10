{ config, lib, ctx, ... }:
let
  cfg = config.modules.constellation;
  inputs = ctx.inputs;
in
  {
  # Note: This part of the moduleset is unstable, and may change due to implementation details in the underlying apps.
  options.modules.constellation.enable = lib.mkEnableOption "the constellation apps";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with inputs; [
      self.packages.${pkgs.system}.pyxis
      horologium.packages.${pkgs.system}.horologium-cli
    ];
  };
}
  
