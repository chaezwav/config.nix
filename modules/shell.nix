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

        if test "$TERM" = "xterm-ghostty"
            if status is-interactive
                eval (zellij setup --generate-auto-start fish | string collect)
            end
            fastfetch
        end
      '';
      shellAliases = {
        ls = "lla";
      };
      functions = {
        fish_prompt = ''
          set -l nix_shell_info (
            if test -n "$IN_NIX_SHELL"
              echo -n "<nix-shell> "
            end
          )

          echo -n -s "$nix_shell_info ~> "
        '';
      };
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

    zellij = {
      enable = true;
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
