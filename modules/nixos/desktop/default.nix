{ config, lib, pkgs, ... }:
let
  cfg = config.modules.desktop;
in
  {
  imports = [
    ./hyprland.nix
    ./portal.nix
    ./display.nix
    ./niri.nix
  ];
  options.modules.desktop.enable = lib.mkEnableOption "desktop defaults (portals, sddm)";
  options.modules.desktop.hyprland.enable = lib.mkEnableOption "hyprland";
  options.modules.desktop.niri.enable = lib.mkEnableOption "niri";
}
