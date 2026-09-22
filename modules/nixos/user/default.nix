{ config, lib, pkgs, ctx, ... }:
let
  cfg = config.modules.user;
  inputs = ctx.inputs;
in
  {
  options.modules.user.enable = lib.mkEnableOption "default user configured for this moduleset.";
  options.modules.user.extraImports = lib.mkOption {
    type = lib.types.listOf lib.types.path;
    default = [];
    description = "Additional imports for home-manager";
  };
  config = lib.mkIf cfg.enable {
    users.users = {
      Stelare = {
        isNormalUser = true;
        description = "Stelare";
        extraGroups = [ "wheel" ];
        shell = pkgs.fish;
      };
    };

    home-manager = {
      extraSpecialArgs = { inherit ctx; nixcfg = config; };
      users = {
        "Stelare" = {
          imports = [ 
            (ctx.root + /common/users/stelare.nix) 
            inputs.sops-nix.homeManagerModule
          ] ++ cfg.extraImports;
        };
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
