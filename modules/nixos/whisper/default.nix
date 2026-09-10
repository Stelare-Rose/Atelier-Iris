{ config, lib, pkgs, ... }:
let
  cfg = config.modules.whisper;
in 
  {
  options.modules.whisper.enable = lib.mkEnableOption "whisper-cpp and server";
  config = lib.mkIf cfg.enable {
    # TODO: Explore if you can declaratively download the models.
    environment.systemPackages = with pkgs; [
      whisper-cpp
    ];
  };
}
