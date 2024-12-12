{
  description = "NixOS system configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ghostty = {
      url = "git+ssh://git@github.com/ghostty-org/ghostty.git";

      # NOTE: The below 2 lines are only required on nixos-unstable,
      # if you're on stable, they may break your build
      inputs.nixpkgs-stable.follows = "nixpkgs";
      inputs.nixpkgs-unstable.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ghostty, nix-index-database, ... }: {
    nixosConfigurations.performante = nixpkgs.lib.nixosSystem {
      modules = [
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.koehn = import ./home.nix;
          };

          programs.nix-index-database.comma.enable = true;

          environment.systemPackages = with ghostty; [
            packages.x86_64-linux.default
          ];
        }
        ./configuration.nix
        home-manager.nixosModules.home-manager
        nix-index-database.nixosModules.nix-index
      ];
    };
  };
}
