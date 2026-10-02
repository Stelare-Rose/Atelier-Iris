{ config, nixcfg, lib, pkgs, ... }:
let
  cfg = config.home.rofi;
in
  {
  options.home.rofi.enable = lib.mkOption {
    type = lib.types.bool;
    default = nixcfg.modules.desktop.enable;
    description = "Enables rofi";
  };
  config = lib.mkIf cfg.enable {
    xdg.configFile."rofi/catppuccin-latte.rasi".source = config.util.link "/dotfiles/rofi/catppuccin-latte.rasi";
    home.packages = with pkgs; [
      rofi-network-manager
    ];
    programs.rofi = {
      enable = true;
      package = pkgs.rofi;
      plugins = with pkgs; [
        rofi-calc
        rofi-top
      ];
      theme = ./theme/catppuccin-default.rasi;
      extraConfig = {
        modi = "drun,combi,calc,top";
        font = "Monaspace Neon 11";
      };
    };
  };
}
