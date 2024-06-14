{
    description = "A test flake";

    inputs = {
      nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

      # nix-darwin.url = "github:LnL7/nix-darwin";
      # nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

      home-manager.url = "github:nix-community/home-manager";
      home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = inputs @ {
        self,
        nixpkgs,
        # nix-darwin,
        home-manager,
        ...
    }: {
      homeConfigurations = {
        "gordo" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          extraSpecialArgs = {
            inherit inputs;
          };
          modules = [
            ({pkgs, ...}: {
              nix.package = pkgs.nix;
              home.username = "gordo";
              home.homeDirectory = "/Users/gordo";
              imports = [./macos/home.nix];
             })
          ];
        };
      };
    };
}
