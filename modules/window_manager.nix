{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:
{
  services.gnome-keyring.enable = true;

  home.packages = with pkgs; [
    grim
    slurp
    wl-clipboard
    mako
    fuzzel
    swaybg
    dconf
  ];

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.rose-pine-cursor;
    name = "BreezeX-RosePine-Linux";
    size = 32;
  };

  programs.fuzzel = {
    enable = true;
    settings = lib.mkForce {
      main = {
        font = "CommitMono:size=14";
        use-bold = true;
        prompt = "~> ";
        placeholder = " Search for...";
      };
    };
  };

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "CommitMono" ];
      serif = [ "Noto Serif" ];
      sansSerif = [ "Noto Sans" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };

  # wayland.windowManager.hyprland = {
  #   enable = true;
  #   xwayland.enable = true;
  # };

  # services.hyprpaper = {
  #   enable = true;
  #   settings = {
  #     ipc = "on";
  #     splash = false;

  #     preload = [
  #       "/home/koehn/Documents/nixos-config/assets/miffy-wallpaper.jpg"
  #     ];
  #     wallpaper = [ "/home/koehn/Documents/nixos-config/assets/miffy-wallpaper.jpg" ];
  #   };
  # };

  # home.file."~/.config/hypr/hyprland.conf".text = ''
  #   $mainMod = SUPER
  #   $terminal = ghostty
  #   $menu = fuzzel

  #   bind = $mainMod, ENTER, exec, $terminal
  #   bind = $mainMod, SPACE, exec, $menu
  #   bind = $mainMod, Q, killactive,
  #   bind = $mainMod SHIFT, Q, exit,
  # '';

  programs.niri.settings = {
    binds = with config.lib.niri.actions; let
        sh = spawn "sh" "-c";
    in { 
      "Mod+Return".action = spawn "ghostty";
      "Mod+Space".action = spawn "fuzzel";

      "Mod+Q".action = close-window;
      "Mod+Shift+Q".action = quit { skip-confirmation=true; };

      "Print".action = sh ''grim -g "$(slurp)" - | wl-copy'';
    };

    layout = {
      center-focused-column = "always";
    };

    window-rules = [
      {
        geometry-corner-radius = {
          top-left = 8.0;
	  top-right = 8.0;
	  bottom-left = 8.0;
	  bottom-right = 8.0;
	};
	clip-to-geometry = true;
      }
      {
        matches = [{app-id = "^firefox$";}];
        open-maximized = true;
      }
    ];
  };

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true; # Fixes common issues with GTK 3 apps
    config = {
      modifier = "Mod4";
      terminal = "ghostty";
      menu = "fuzzel";
      startup = [
        { command = "swaybg -m fill -i /home/koehn/Documents/nixos-config/assets/miffy-wallpaper.jpg"; }
        { command = "firefox"; }
      ];
      gaps = {
        inner = 10;
        outer = 10;
      };

      window.titlebar = false;

      keybindings =
        let
          modifier = config.wayland.windowManager.sway.config.modifier;
        in
        lib.mkOptionDefault {
          "${modifier}+q" = "kill";
        };
    };

    extraConfig =
      let
        modifier = config.wayland.windowManager.sway.config.modifier;
      in
      ''
        bindsym ${modifier}+p exec grim -g "$(slurp -d)" - | wl-copy
      '';
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };
}
