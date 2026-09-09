{ config, lib, pkgs, ... }:
let
  cfg = config.modules.nix-ld;
in
  {
  options.modules.nix-ld.enable = lib.mkEnableOption "nix-ld and libraries";
  config = lib.mkIf cfg.enable {
    programs.nix-ld.enable = true;
    programs.nix-ld.libraries = with pkgs; [
      xorg.libICE
      xorg.libSM
      xorg.libX11
      icu
      fontconfig
    ];
  };
}
