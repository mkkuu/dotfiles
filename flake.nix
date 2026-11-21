
{
  description = "Mkkuu's NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixpkgs-brave.url =
      "github:NixOS/nixpkgs/cc588038c06d9a7c687b82a38112442f97649b31";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          ({ ... }: {
            nixpkgs.overlays = [
              (final: prev: {
                brave = inputs.nixpkgs-brave.legacyPackages.${system}.brave;
              })
            ];
          })

          ./nixos/configuration.nix

          home-manager.nixosModules.home-manager

          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.extraSpecialArgs = {
              inherit inputs;
            };

            home-manager.users.mkkuu = import ./home-manager/home.nix;
          }
        ];
      };
    };
}
