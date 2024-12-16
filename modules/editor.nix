{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nixd
    nil
    nixfmt-rfc-style
  ];

  programs.zed-editor = {
    enable = true;
    extensions = [
      "nix"
      "toml"
    ];
    userSettings = {
      hour_format = "hour24";
      auto_update = false;
      ui_font_size = 16;
      buffer_font_size = 16;

      theme = {
        mode = "dark";
        dark = "Rosé Pine";
        light = "Rosé Pine Dawn";
      };

      buffer_font_family = "CommitMono";

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
