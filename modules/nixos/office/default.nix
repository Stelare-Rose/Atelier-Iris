{ config, lib, pkgs, ... }:
let 
  cfg = config.modules.office;
in
  {
  options.modules.office.enable = lib.mkEnableOption "office and productivity packages";
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      libreoffice-qt6-still
      obsidian
      zathura
      presenterm
      pandoc
      texliveFull
      zip
      unzip
      rar
    ];
  };
}
