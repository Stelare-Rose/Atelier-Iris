{ ctx, ... }:
let
  root = ctx.root;
in
  {
  imports = [
    ../../common/default.nix
    ./hardware.nix
  ];
  modules = {
    user.extraImports = [ ./users/stelare.nix ];
    wireguard.secretPath = root + /secrets/crescent/wireguard/wg0.conf;
  };
}
