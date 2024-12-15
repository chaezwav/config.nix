{
  # inputs,
  ...
}:
{
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
        ls = "lla";
      };
      functions = {
        fish_prompt = ''
          set -l nix_shell_info (
            if test -n "$IN_NIX_SHELL"
              echo -n "<nix-shell>"
            end
          )

          printf '%s%s%s %s%s%s ~> ' (set_color red) $nix_shell_info (set_color normal) \
            (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
        '';
      };
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
