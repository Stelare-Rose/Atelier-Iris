{ config, pkgs, module, unstable, inputs, ... }:
{
	imports = [
		(module + "/home/Productivity/Musescore")
		(module + "/home/Productivity/Thunderbird")
		(module + "/home/Nvim")
		(module + "/home/Yazi")
		(module + "/home/Tmux")
		(import (module + "/home/rofi") {inherit config pkgs unstable;})
		
		inputs.zen-browser.homeModules.default
	];
	nixpkgs.config.allowUnfree = true;
	home.username = "Stelare";
	home.homeDirectory = "/home/Stelare";
	home.stateVersion = "24.05"; 

	# Virtualization
	dconf.settings = {
		"org/virt-manager/virt-manager/connections" = {
			autoconnect = ["qemu:///system"];
			uris = ["qemu:///system"];
		};
	};
	# Music Player

	#User Programs
	programs.waybar = {
		enable = true;
	};
	programs.starship.enable = true;
	programs.home-manager.enable = true;
	# Pyxis
	systemd.user.services.pyxis = {
		Unit = {
			Description = "Background Indexing and Notification service for Pyxis";
		};
		Install = {
			WantedBy = [ "default.target" ];
		};
		Service = {
			ExecStart = "${pkgs.writeShellScript "watch-store" ''
						#!/run/current-system/sw/bin/fish
						cd /home/Stelare/Sync/Programming/Git/Pyxis-Service/bin
						./Pyxis-Service
						''}";
		};
	};
	programs.zen-browser.policies = {
		AutofillAddressEnabled = true;
		AutofillCreditCardEnabled = false;
		DisableAppUpdate = true;
		DisableFeedbackCommands = true;
		DisableFirefoxStudies = true;
		DisablePocket = true;
		DisableTelemetry = true;
		DontCheckDefaultBrowser = true;
		NoDefaultBookmarks = true;
		OfferToSaveLogins = false;
		EnableTrackingProtection = {
			Value = true;
			Locked = true;
			Cryptomining = true;
			Fingerprinting = true;
		};
	};
}
