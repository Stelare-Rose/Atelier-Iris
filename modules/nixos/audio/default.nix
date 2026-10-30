{ config, lib, pkgs, ... }:
let
  cfg = config.modules.audio;
in
  {
  options.modules.audio.enable = lib.mkEnableOption "audio settings (default pipewire-pulse + alsa + jack)";
  config = lib.mkMerge [
    (lib.mkIf (config.modules.user.enable && cfg.enable) {
      users.users.Stelare.extraGroups = [ "audio" ];
    })
    (lib.mkIf cfg.enable {
      environment.systemPackages = with pkgs; [
        pavucontrol
      ];
      nixpkgs.config.pulseaudio = true;
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        audio.enable = true;
        pulse.enable = true;
        jack.enable = true;
        alsa = {
          enable = true;
          support32Bit = true;
        };
        extraConfig.pipewire."92-default" = {
          "context.properties" = {
            "default.clock.rate" = 48000;
            "default.clock.min-quantum" = 1024;
            "default.clock.max-quantum" = 2048;
          };
        };
        extraConfig.pipewire."99-record-sink" = {
          "context.modules" = [
            {
              name = "libpipewire-module-loopback";
              args = {
                "node.description" = "Stream_Sink";
                "capture.props" = {
                  "node.name" = "stream_sink";
                  "media.class" = "Audio/Sink";
                  "audio.position" = [ "FL" "FR" ];
                };
                "playback.props" = {
                  "node.name" = "stream_sink_out";
                  "node.passive" = true;
                };
              };
            }
          ];
        };
      };
    })
  ];
}
