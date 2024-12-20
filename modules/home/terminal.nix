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

        theme = "rose-pine";
        cursor-style = "bar";
        window-theme = "ghostty";
	adw-toolbar-style = "flat";

        shell-integration-features = "sudo, title";
        shell-integration = "fish";

        confirm-close-surface = false;
      };
}
