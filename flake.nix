{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    nvf.url = "github:notashelf/nvf";
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    nvf,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};

    customNeovim = nvf.lib.neovimConfiguration {
      inherit pkgs;
      modules = [./neovim.nix];
    };
  in {
    # This will make the package available as a flake output under 'packages'
    packages.${system}.my-neovim = customNeovim.neovim;

    # Example Home-Manager configuration using the configured Neovim package
    homeConfigurations = {
      aids = home-manager.lib.homeManagerConfiguration {
        # ...
        inherit pkgs;
        modules = [
          ./home.nix
          # This will make Neovim available to users using the Home-Manager
          # configuration. To make the package available to all users, prefer
          # environment.systemPackages in your NixOS configuration.
          {home.packages = [customNeovim.neovim];}
        ];
      };
    };
  };
}

