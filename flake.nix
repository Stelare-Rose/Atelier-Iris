{
  description = "NixOS Config Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.home-manager.follows = "home-manager";
    };
    # Constellations
    horologium = {
      url = "git+https://git.starrytea.cc/Constellation-Project/Horologium.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs: {
  };
}
