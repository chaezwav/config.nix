{
  # inputs,
  ...
}: {
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

        test "$TERM" = "xterm-ghostty" && fastfetch
      '';
    };

    bat = {
      enable = true;
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
