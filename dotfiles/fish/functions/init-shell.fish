function init-shell --description "Generate a flake.nix dev shell with a tmux session"
    set -l name (basename $PWD)
    set -q argv[1]; and set name $argv[1]

    if test -e flake.nix
        echo "flake.nix already exists, not overwriting." >&2
        return 1
    end

    echo '{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
  };

  outputs = { self, nixpkgs }@inputs:
    let
      system = "x86_64-linux";

      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      devShells.${system}.default = pkgs.mkShell rec {
        name = "@NAME@";
        packages = with pkgs; [
        ];
        shellHook = "tmux -L ${name} new-session -A -s ${name}";
      };
    };
}' | string replace -a @NAME@ $name >flake.nix

    echo "Created flake.nix for '$name'"
end
