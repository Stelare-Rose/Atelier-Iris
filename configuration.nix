# Edit this conniguration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, module, unstable, self, ... }:
{
	# Imports
	nixpkgs.config.allowUnfree = true;
	hardware.enableAllFirmware = true;
	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	imports =
		[ # Include the results of the hardware scan.
			(module + "/environment/Utilities/Passwords")
			(module + "/environment/Utilities/Appimage-Utils")
			(module + "/environment/Utilities/Images")
			(module + "/environment/Zen")
			inputs.home-manager.nixosModules.default
		];


	#User Account
	users.users = {
		Stelare = {
			extraGroups = [ "video" "games" "i2c" ];
		};
	};
	home-manager = {
		extraSpecialArgs = { inherit inputs unstable module; };
		users = {
			"Stelare" = import ./users/stelare.nix;
		};
	};

	#Boot Modules

	#System Packages
	environment.systemPackages = with pkgs; [
		sof-firmware
		waybar
    bitwarden-cli
		godot_4
		brightnessctl
		stow
		rmpc
		via
		dotool
		yazi
		self.packages.${pkgs.system}.pyxis
		nautilus
    mendeley
    ddcutil
    whisper-cpp
    inputs.horologium.packages.${pkgs.system}.horologium-cli
		];

	environment.shells = with pkgs; [
		fish
	];

	#Program Configuration

	# Services
	services.syncthing = {
		dataDir = "/home/Stelare/Sync";
		enable = true;
		openDefaultPorts = true;
		user = "Stelare";
	};

	
	# MySQL Daemon
	system.stateVersion = "24.05"; 
}
