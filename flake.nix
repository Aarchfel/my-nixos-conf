{
  description = "My NixOS Configuration!";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, spicetify-nix, ... }:
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations = {
      nixos-ecosystem = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
	  ./configuration.nix
	  home-manager.nixosModules.home-manager
	  {
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
	    home-manager.extraSpecialArgs = {
	      inherit inputs spicetify-nix;
	    };
	    home-manager.users.nixfel = import ./home.nix;
	  }
	];
      };
    };
  };
}
