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
        shell = pkgs.fish;
      };
    };
    modules.shell.enable = lib.mkDefault true;
    virtualisation.vmVariantWithBootLoader = {
      users.users.Stelare.initialPassword = "password";
    };
    virtualisation.vmVariant = {
      users.users.Stelare.initialPassword = "password";
    };
  };
}
