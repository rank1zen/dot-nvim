{
    description = "A test flake";

    inputs = {
        nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-23.11-darwin";
        darwin = {
            url = "github:lnl7/nix-darwin";
            inputs.nixpkgs.follows = "nixpkgs-darwin";
        };
    };

    outputs = inputs @ {
        self,
        nixpkgs,
        darwin,
        ...
    }: let
        username = "gordon";
        system = "aarch64-darwin";

        hostname = "${username}-macbook";
        specialArgs =
            inputs
            // {
                inherit username hostname;
            };
    in {
        darwinConfigurations."${hostname}" = darwin.lib.darwinSystem {
            inherit system specialArgs;
            modules = [
                ./modules/system.nix
            ];
        };

        formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;
    };
}
