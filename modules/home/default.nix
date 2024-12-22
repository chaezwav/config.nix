{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./shell.nix
    ./ghostty.nix
    ./window_manager.nix
    ./editor.nix
    inputs.nixvim.homeManagerModules.nixvim
    inputs.niri.homeModules.niri
  ];

  programs.home-manager.enable = true;

  home = {
    username = "koehn";
    homeDirectory = "/home/koehn";
    stateVersion = "24.05";
    packages = with pkgs; [
      inkscape
      zed-editor
      _1password-gui-beta
      _1password-cli
      spotify

      git

      nixd
      nil
      nixfmt-rfc-style
    ];
  };
}
