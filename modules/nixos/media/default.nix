{ config, lib, pkgs, ... }:
let
  cfg = config.modules.media;
in
  {
  options.modules.media.viewing.enable = lib.mkEnableOption "media viewing programs";
  options.modules.media.production.enable = lib.mkEnableOption "media production programs";
  config = lib.mkMerge [
    (lib.mkIf cfg.viewing.enable {
      environment.systemPackages = with pkgs; [
        mpv
        vlc
        qimgv
      ];
      xdg.mime.defaultApplications = {
        "video/mp4" = "mpv.desktop";
        "video/x-matroska" = "mpv.desktop";
        "video/webm" = "mpv.desktop";
      };
    })
    (lib.mkIf cfg.production.enable {
      environment.systemPackages = with pkgs; [
        ffmpeg
        audacity
        handbrake
        kdePackages.kdenlive
      ];
    })
  ];
}
