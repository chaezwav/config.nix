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

    color-schemes = {
      url = "github:mbadolato/iTerm2-Color-Schemes";
      flake = false;
    };

    ghosttyModule = {
      url = "github:clo4/ghostty-hm-module";
    };

    home-manager = {
      url = "github:nix-community/home-manager/";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, ghosttyModule, home-manager, color-schemes, ghostty, nix-index-database, ... }: {
    nixosConfigurations.performante = nixpkgs.lib.nixosSystem {
      modules = [
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.koehn = import ./home.nix;
            sharedModules = [ ghosttyModule.homeModules.default ];
            extraSpecialArgs = {
              inherit color-schemes;
            };
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
