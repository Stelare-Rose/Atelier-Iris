{
  description = "NixOS Config Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-release.url = "github:nixos/nixpkgs/release-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.home-manager.follows = "home-manager";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Constellations
    horologium = {
      url = "git+https://git.starrytea.cc/Constellation-Project/Horologium.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Custom Packages / Attachments
    cursor = {
      url = "git+https://git.starrytea.cc/Stelare-Rose/Starry-Cursor.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    self, 
    nixpkgs, 
    nixpkgs-unstable, 
    home-manager, 
    sops-nix,
    horologium, 
    cursor,
    ... }@inputs: 
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system; 
        config.allowUnfree = true;
        config.android_sdk.accept_license = true;
      };
      unstable = import nixpkgs-unstable {
        inherit system; 
        config.allowUnfree = true;
      };

      # Args
      ctx = {
        inherit
        inputs
        unstable
        ;
        root = self;
      };

      modules = [
        home-manager.nixosModules.default
        sops-nix.nixosModules.sops
        horologium.nixosModules.default
      ];

      # Helper Methods
      mkHost = path: nixpkgs.lib.nixosSystem {
        specialArgs = { inherit ctx; };
        modules = path ++ modules;
      };
    in
      {
      # Temporary Pyxis-MVP import
      # TODO: Swap Pyxis to a Flake
      packages.${system}.pyxis = pkgs.callPackage /home/Stelare/Sync/Programming/Git/Pyxis/default.nix { };
      nixosConfigurations.Selene = mkHost [ ./hosts/selene ];
      nixosConfigurations.Crescent = mkHost [ ./hosts/crescent ]; 

      # Server Configuration, Doesn't use Default.
      nixosConfigurations.Copernicus = mkHost [ ];

      # Stripped VM Configuration
      nixosConfigurations.Nyx = mkHost [ ./hosts/nyx ];
    };
}
