{
  # inputs,
  pkgs,
  lib,
  ...
}:
{
  home.packages = with pkgs; [
    bat
  ];

  programs = {
    git = {
      enable = true;
      userName = "Koehn";
      userEmail = "koehn@omg.lol";
      extraConfig = {
        init.defaultBranch = "trunk";
      };
    };

    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting

        if test "$TERM_PROGRAM" = "ghostty"
            fastfetch
        end
      '';
      shellAliases = {
        ls = "eza";
      };
    };

    starship = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        add_newline = false;
        format = lib.concatStrings [
          "$package"
          "$git_branch"
          "$git_status"
          "$directory"
          "$character"
        ];
        scan_timeout = 10;
        character = {
          success_symbol = "[->](bold fg:218)";
          error_symbol = "[~>](bold red)";
          vimcmd_symbol = "[V>](bold green)";
        };
      };
    };

    eza = {
      enable = true;
      enableFishIntegration = true;
      colors = "auto";
      icons = "auto";
      extraOptions = [
        "--hyperlink"
      ];
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
      options = [
        "--cmd cd"
      ];
    };

    fastfetch = {
      enable = true;
      settings = {
        logo = {
          type = "file";
          source = "/home/koehn/Documents/nixos-config/assets/fastfetch_logo.txt";
        };

        modules = [
          "break"
          "title"
          "separator"
          "os"
          "kernel"
          "uptime"
          "packages"
          "break"
          "colors"
          "break"
        ];
      };
    };
  };
}
