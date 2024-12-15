{
  lib,
  ...
}:
{
  xdg.configFile."ghostty/config".text =
    lib.generators.toKeyValue
      {
        mkKeyValue = lib.generators.mkKeyValueDefault { } " = ";
        listsAsDuplicateKeys = true;
      }
      {
        font-family = "CommitMono";
        font-size = 14;
        font-style = "Medium";

        theme = "Pnevma";
        cursor-style = "bar";
        window-theme = "ghostty";

        shell-integration-features = "sudo";
        shell-integration = "fish";

        confirm-close-surface = false;
        window-decoration = false;
      };
}
