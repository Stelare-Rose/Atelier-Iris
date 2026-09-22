{ config, nixcfg, lib, pkgs, ... }:
let
  cfg = config.home.whisper;
in
  {
  options.home.whisper.enable = lib.mkEnableOption "whisper server on port 29076";
  config = lib.mkIf cfg.enable {
    systemd.user.services.whisper = {
      Unit = {
        Description = "Whisper Transcription Server";
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
      Service = {
        ExecStart = "${pkgs.whisper-cpp}/bin/whisper-server --host 0.0.0.0 --port 29076 -m /var/lib/whisper-models/model.bin --convert";
        Path = [ pkgs.whisper-cpp ];
      };
    };

  };
}

