{
  description = "NixOS system configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # stylix.url = "github:danth/stylix";
    # hyprland.url = "github:hyprwm/Hyprland";

    niri.url = "github:sodiboo/niri-flake";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nh = {
      url = "github:viperML/nh";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

  outputs =
    inputs@{
      self,
      nixpkgs,
      ...
    }:
    {
      nixosConfigurations.performante = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.koehn = import ./home.nix;
            };

            programs.nix-index-database.comma.enable = true;

            environment.systemPackages = with inputs; [
              ghostty.packages.x86_64-linux.default
              nh.packages.x86_64-linux.default
            ];
          }
          ./configuration.nix
          inputs.home-manager.nixosModules.home-manager
          inputs.nix-index-database.nixosModules.nix-index
	  inputs.niri.nixosModules.niri
          # stylix.nixosModules.stylix
        ];
      };
    };
}
