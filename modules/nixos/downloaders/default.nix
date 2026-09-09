{ config, lib, pkgs, ctx, ... }:
let
  cfg = config.modules.downloaders;
  unstable = ctx.unstable;
in
  {
  options.modules.downloaders.enable = lib.mkEnableOption "various downloaders";
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      ffmpeg
      transmission_4-gtk
      unstable.yt-dlp
    ];
  };
}
