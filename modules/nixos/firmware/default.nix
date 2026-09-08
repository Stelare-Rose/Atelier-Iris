{ config, lib, ... }:
let
  cfg = config.modules.firmware;
in
  {
  options.modules.firmware.enableAll = lib.mkEnableOption "all firmware and unfree nixpkgs";
  config = lib.mkIf cfg.enableAll {
    nixpkgs.config.allowUnfree = true;
    hardware.enableAllFirmware = true;
  };
}

