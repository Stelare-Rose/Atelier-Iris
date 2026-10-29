{ pkgs, ... }:
let
  librewolfWrapped = pkgs.wrapFirefox pkgs.librewolf-unwrapped {
    pname = "librewolf";
    applicationName = "librewolf";
    libName = "librewolf"; 
    wmClass = "LibreWolf";

    extraPolicies = {
      ExtensionSettings = {
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          installation_mode = "force_installed";
        };
        "{3c078156-979c-498b-8990-85f7987dd929}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/sidebery/latest.xpi";
          installation_mode = "force_installed";
        };
         "{e839c3f9-298e-4cd0-99e0-464431cb7c34}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/foxy-gestures/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };

    inherit (pkgs.librewolf-unwrapped) extraPrefsFiles extraPoliciesFiles;
    extraPrefs = builtins.readFile ./aster.cfg;
  };

  # I renamed this so it's left-hand only, because I open browser that often
  aster = pkgs.symlinkJoin {
    name = "aster";
    paths = [ librewolfWrapped ];
    postBuild = ''
      if [ -f $out/bin/librewolf ]; then
        real_bin=$(readlink -f $out/bin/librewolf)
        rm $out/bin/librewolf
        ln -s "$real_bin" $out/bin/aster
      fi
      
      for desktop in $out/share/applications/*.desktop; do
        if [ -f "$desktop" ]; then
          target=$(readlink -f "$desktop")
          rm "$desktop"
          cp "$target" "$desktop"
          chmod +w "$desktop"
          substituteInPlace "$desktop" \
            --replace "Exec=librewolf" "Exec=aster" \
            --replace "Name=LibreWolf" "Name=Aster"
        fi
      done    '';
  };
in
aster
