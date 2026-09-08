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
			(module + "/environment/Hyprland")
			(module + "/environment/Utilities/Passwords")
			(module + "/environment/Utilities/Wayland")
			(module + "/environment/Utilities/Appimage-Utils")
			(module + "/environment/Utilities/Images")
			(module + "/environment/Productivity/adb")
			(module + "/environment/Productivity/android-emu")
			(module + "/environment/Zen")
			inputs.home-manager.nixosModules.default
		];

  boot.extraModprobeConfig = ''
    install esp4 ${pkgs.coreutils}/bin/false
    install esp6 ${pkgs.coreutils}/bin/false
    install rxrpc ${pkgs.coreutils}/bin/false
  '';
  boot.blacklistedKernelModules = [
    "esp4"
    "esp6"
    "rxrpc"
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
		dbeaver-bin
		sqlcmd
		brightnessctl
		stow
		openssl
		rmpc
		transmission_4-gtk
		signal-desktop
		via
		temurin-bin-21
		unstable.zoom-us
		dotool
		mysql84
		yazi
		unstable.opencode
		self.packages.${pkgs.system}.pyxis
		nautilus
    posting
    cloudflared
    mendeley
    android-tools
    tokei
    jq
    ddcutil
    unstable.yt-dlp
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
	services.mysql = {
		enable = true;
		package = pkgs.mysql84;
	};
	system.stateVersion = "24.05"; 

	programs.nix-ld.enable = true;
	programs.nix-ld.libraries = with pkgs; [
		xorg.libICE
		xorg.libSM
		xorg.libX11
		icu
		fontconfig
	];


}


