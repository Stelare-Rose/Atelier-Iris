{ config, lib, ctx, pkgs, ... }:
let
  cfg = config.modules.browser;
  inputs = ctx.inputs;
in
  {
  options.modules.browser.enable = lib.mkEnableOption "browser";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default ];
  };
}
