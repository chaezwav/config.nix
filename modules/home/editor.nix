{ pkgs, ... }:
{
  programs.nixvim = {
    enable = true;
    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
    };
    extraPlugins = with pkgs; [ vimPlugins.kanagawa-nvim ];
    colorscheme = "kanagawa-wave";
    plugins = {
      lsp = {
        enable = true;
        servers = {
          nixd = {
            enable = true;
            package = pkgs.nixd;
            autostart = true;
            cmd = [
              "nixd"
            ];
            settings.formatting.command = [ "nixfmt" ];
          };
        };
      };

      lsp-format = {
        enable = true;
        settings = {
          nixd = {
            sync = true;
          };
        };
      };

      coq-nvim = {
        enable = true;
        settings = {
          auto_start = "shut-up";
        };
        installArtifacts = false;
      };

      bufferline.enable = true;
      web-devicons.enable = true;
    };
  };

  programs.zed-editor = {
    enable = true;
    extensions = [
      "nix"
      "toml"
      "kanagawa-themes"
    ];
    userSettings = {
      hour_format = "hour24";
      auto_update = false;

      ui_font_size = 16;
      buffer_font_size = 16;
      buffer_font_family = "CommitMono";

      theme = {
        mode = "dark";
        dark = "Kanagawa Wave";
        light = "Kanagwa Lotus";
      };

      tabs = {
        file_icons = true;
        git_status = true;
      };

      indent_guides = {
        enabled = true;
        coloring = "indent_aware";
      };

      languages = {
        Nix = {
          language_servers = [
            "nixd"
            "!nil"
          ];
          formatter = "language_server";
          format_on_save = "on";
        };
      };

      lsp.nixd.settings = {
        formatting.command = [ "nixfmt" ];
      };

      assistant = {
        enabled = false;
        version = "2";
        default_model = {
          provider = "copilot_chat";
          model = "o1-preview";
        };
      };
    };
  };
}
