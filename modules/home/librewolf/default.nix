{ config, nixcfg, lib, pkgs, ctx, ... }:
let
  cfg = config.home.librewolf;
  root = ctx.root;
in {
  options.home.librewolf.enable = lib.mkOption {
    type = lib.types.bool;
    default = nixcfg.modules.browser.enable;
    description = "Enables librewolf configuration";
  };
  config = lib.mkIf cfg.enable {
    programs.librewolf = {
      enable = true;
      package = pkgs.callPackage (root + "/attachments/aster/aster.nix") { };
      profiles.default = {
        isDefault = true;
        userChrome = builtins.readFile ./userChrome.css;
      };
    };
  };
}
