# /etc/nixos/flake.nix

{
  description = "NixOS System Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    # Home Manager unstable branch
    home-manager = {
      url = "github:nix-community/home-manager/master"; # <-- This is the unstable branch
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-flatpak, home-manager, ...}@inputs:

  let
    # Define your username here at the flake level
    # This is the single place to change it for this system
    systemUsername = "your-username"; # <--- IMPORTANT: Change this line to your desired username

    # Define your hostname here at the flake level
    # This is the single place to change it for this system
    systemHostname = "your-hostname"; # <--- IMPORTANT: Change this line to your desired hostname
  in

    {
    nixosConfigurations.${systemHostname} = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      pkgs = import nixpkgs {
       system = "x86_64-linux";
       config.allowUnfree = true;
      };
      modules = [
        ./configuration.nix
        nix-flatpak.nixosModules.nix-flatpak

        # Home Manager module
        home-manager.nixosModules.home-manager
      ];

      # Pass special arguments to your modules
      specialArgs = {
        inherit inputs systemUsername systemHostname; # Make both available to modules
      };
    };
  };
}
