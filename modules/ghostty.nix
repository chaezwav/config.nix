{ lib
, ...
}: {
  xdg.configFile."ghostty/config".text =
    lib.generators.toKeyValue
      {
        mkKeyValue = lib.generators.mkKeyValueDefault { } " = ";
        listsAsDuplicateKeys = true;
      }
      {
        confirm-close-surface = false;
        font-family = "CommitMono";
        font-size = 14;
        font-style = "Medium";
        minimum-contrast = 1.1;
        theme = "Pnevma";
        cursor-style = "bar";
        window-theme = "ghostty";
        shell-integration-features = "sudo";
      };
}
