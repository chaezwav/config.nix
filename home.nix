{
  pkgs,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./modules/shell.nix
    ./modules/terminal.nix
    ./modules/window_manager.nix
    ./modules/editor.nix
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

      nixd
      nil
      nixfmt-rfc-style

      git

      lla
      bat
    ];
  };
}
