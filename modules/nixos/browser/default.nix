{ config, lib, ctx, pkgs, ... }:
let
  cfg = config.modules.browser;
  inputs = ctx.inputs;
  root = ctx.root;
in
  {
  options.modules.browser.enable = lib.mkEnableOption "browser";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ 
      inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default
      # Chromium is included here because firefox issues.
      chromium
      (callPackage (root + "/attachments/aster/aster.nix") {})
    ];
  };
}
