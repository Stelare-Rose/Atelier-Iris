{ config, lib, pkgs, ... }:
let
  cfg = config.modules.creative;
in
  {
  options.modules.creative.enable = lib.mkEnableOption "creative/design packages";
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      musescore
      krita
      aseprite
    ];
  };
}
