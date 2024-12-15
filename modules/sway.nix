{
  ...
}:
{
  services.gnome-keyring.enable = true;

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true; # Fixes common issues with GTK 3 apps
    config = rec {
      modifier = "Mod4";
      terminal = "ghostty";
      startup = [
        { command = "firefox"; }
      ];
      gaps = {
        inner = 10;
        outer = 10;
      };
    };
  };

}
