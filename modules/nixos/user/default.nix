{ config, lib, pkgs, ... }:
let
  cfg = config.modules.user;
in
  {
  options.modules.user.enable = lib.mkEnableOption "default user configured for this moduleset.";
  config = lib.mkIf cfg.enable {
    users.users = {
      Stelare = {
        isNormalUser = true;
        description = "Stelare";
        extraGroups = [ "wheel" ];
        shell = lib.mkDefault pkgs.fish;
      };
    };
    modules.shells.fish.enable = lib.mkIf (
      config.users.users.Stelare.shell == pkgs.fish
    ) (lib.mkDefault true);
  };
}
