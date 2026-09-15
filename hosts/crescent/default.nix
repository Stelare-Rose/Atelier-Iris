{ ... }:
{
  imports = [
    ../../common/default.nix
    ./hardware.nix
  ];
  modules.user.extraImports = [ ./users/stelare.nix ];
}
