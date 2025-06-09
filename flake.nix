{
  inputs = {
    # This is pointing to an unstable release.
    # If you prefer a stable release instead, you can this to the latest number shown here: https://nixos.org/download
    # i.e. nixos-24.11
    # Use `nix flake update` to update the flake to the latest revision of the chosen release channel.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    nvf.url = "github:notashelf/nvf";
    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    nvf,
    stylix,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };
  in {
    nixosConfigurations.balls = nixpkgs.lib.nixosSystem {
      system = system;
      modules = [
        nvf.nixosModules.default
        stylix.nixosModules.stylix
        ./hosts/balls/default.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.aids = ./hosts/balls/home.nix;
        }
      ];
    };
    nixosConfigurations.zooker = nixpkgs.lib.nixosSystem {
      system = system;
      modules = [
        nvf.nixosModules.default
        stylix.nixosModules.stylix
        ./hosts/zooker/default.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.aids = ./hosts/zooker/home.nix;
        }
      ];
    };
  };
}
