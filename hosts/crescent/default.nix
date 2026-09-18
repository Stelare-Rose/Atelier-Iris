{ ctx, ... }:
let
  inputs = ctx.inputs;
  root = ctx.root;
in
  {
  imports = [
    ../../common/default.nix
    ./hardware.nix
  ];
  networking.hostName = "Crescent"; 
  # Temporary workaround for bug regarding R680M, swap linux-firmware to the release version.
  nixpkgs.overlays = [
    (final: prev: {
      linux-firmware = (import inputs.nixpkgs-release {
        system = prev.stdenv.hostPlatform.system;
        config.allowUnfree = true;
      }).linux-firmware;
    })
  ];
  sops.age.keyFile = "/home/Stelare/.config/sops/age/keys.txt";
  modules = {
    user.extraImports = [ ./users/stelare.nix ];
    wireguard.secretPath = root + /secrets/crescent/wireguard/wg0.conf;
  };
}
