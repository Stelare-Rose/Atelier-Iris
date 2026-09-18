{ ctx, pkgs, ... }:
let
  root = ctx.root;
in
  {
  imports = [
    ../../common/default.nix
    ./hardware.nix
  ];
	services.xserver.deviceSection = ''
	    Option "VariableRefresh" "true"
	'';
  boot.kernelModules = [
    "i915"
    "nfs"
  ];
	boot.kernelParams = [ "i915.enable_guc=3" ];
	hardware.enableRedistributableFirmware = true;
  networking.hostName = "Selene";
  sops.age.keyFile = "/home/Stelare/.config/sops/age/keys.txt";
	hardware.graphics = {
		enable = true;
		extraPackages = with pkgs; [
			intel-media-driver
			intel-compute-runtime
			vpl-gpu-rt
			intel-graphics-compiler
			level-zero
		];
	};
	services.sunshine = {
		enable = true;
		autoStart = true;
		capSysAdmin = true;	
    openFirewall = true;
	};
  modules = {
    user.extraImports = [ ./users/stelare.nix ];
    wireguard.secretPath = root + /secrets/selene/wireguard/wg0.conf;
  };
}
