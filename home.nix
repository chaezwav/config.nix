{
  pkgs,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./modules/home/shell.nix
    ./modules/home/terminal.nix
    ./modules/home/window_manager.nix
    ./modules/home/editor.nix
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

      git
    ];
  };
}
