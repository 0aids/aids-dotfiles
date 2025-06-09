{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: let
  sharedStylix = import ./../global/stylix-main.nix {
    inherit pkgs;
    inherit config;
  };
in {
  stylix =
    sharedStylix
    // {
      targets = {
        qt.enable = true;
        qt.platform = "qtct";
        gtk.enable = true;
        # foot.enable = true;
        # nvf.enable = true;
        # tofi.enable = true;
        waybar.addCss = false;
        vencord.extraCss = builtins.readFile ./discord/system24.css;
      };

      iconTheme = {
        enable = true;
        package = pkgs.gruvbox-plus-icons;
        dark = "Gruvbox-Plus-Dark";
      };
    };
}
