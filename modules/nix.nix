{ pkgs, lib, ... }:
{
  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nixVersions.latest;
    settings = {
      warn-dirty = lib.mkDefault false;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [
        "https://aseipp-nix-cache.freetls.fastly.net"
      ];
    };
  };
}
