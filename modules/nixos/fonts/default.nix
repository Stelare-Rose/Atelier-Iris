{ config, lib, pkgs, ... }:
let 
  cfg = config.modules.fonts;
in
  {
  options.modules.fonts.enable = lib.mkEnableOption "fonts commonly used in this config";
  config = lib.mkIf cfg.enable {
    fonts.packages = with pkgs; [
      monaspace
      fira-sans
      open-sans
      noto-fonts
      cascadia-code
      nunito
      nerd-fonts.monaspace
      nerd-fonts.monofur
      nerd-fonts.symbols-only
    ];
  };
}
