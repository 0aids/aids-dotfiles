{
  pkgs,
  config,
  ...
}: let
  # NOTE: Edit schema here:
  #
  scheme = "gruvbox-material-dark-hard";
  # scheme = "atelier-forest";
  mode = "dark";
  wallpaper = ./../../wall/image.png;
  # wallpixels = config.lib.stylix.pixel "base00";
in {
  enable = true;
  polarity = mode;
  autoEnable = true;
  image = wallpaper;
  base16Scheme = "${pkgs.base16-schemes}/share/themes/${scheme}.yaml";

  fonts = {
    sizes = {
      terminal = 10;
      desktop = 6;
      popups = 6;
    };
    monospace = {
      package = pkgs.nerd-fonts.blex-mono;
      name = "BlexMono Nerd Font Medium";
    };
  };

  cursor = {
    package = pkgs.capitaine-cursors-themed;
    name = "Capitaine Cursors (Gruvbox)";
    size = 18;
  };
}
