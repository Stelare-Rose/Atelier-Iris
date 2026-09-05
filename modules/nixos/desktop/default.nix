{ config, lib, pkgs, ... }:
let
  cfg = config.modules.desktop;
in
  {
  imports = [
    ./hyprland.nix
    ./portal.nix
    ./display.nix
  ];
  options.modules.desktop.enable = lib.mkEnableOption "desktop defaults (wayland + hyprland)";
}
