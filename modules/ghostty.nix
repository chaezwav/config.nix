{ color-schemes
, ...
}: {
  programs.ghostty = {
    enable = true;
    shellIntegration.enable = false;
    shellIntegration.enableFishIntegration = true;
    settings = {
      font-size = 14;
      font-family = "CommitMono";
      window-theme = "ghostty";

      config-file = [
        (color-schemes + "/ghostty/Pnevma")
      ];
    };
  };
}
