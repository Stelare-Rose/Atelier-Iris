{ config, lib, pkgs, ... }:
let
  cfg = config.modules.user;
in
  {
  options.modules.user.enable = lib.mkEnableOption "enables the default user configured for this moduleset.";
  config = lib.mkIf cfg.enable {
    users.users = {
      Stelare = {
        isNormalUser = true;
        description = "Stelare";
        shell = pkgs.fish;
      };
    };
    programs.fish.enable = true;
  };
}
