{ ctx, ... }:
let
  inputs = ctx.inputs;
  root = ctx.root;
in
  {
  imports = [
    ../../common/default.nix
    ./hardware.nix
    ./modules/kanata
  ];
  networking.hostName = "Crescent"; 
  sops.age.keyFile = "/home/Stelare/.config/sops/age/keys.txt";
  modules = {
    user.extraImports = [ ./users/stelare.nix ];
    wireguard.secretPath = root + /secrets/crescent/wireguard/wg0.conf;
  };
  users.users.Stelare.openssh.authorizedKeys.keyFiles = [
    (root + /keys/Selene.pub)
  ];
}
