{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  stylix = {
    enable = true;
    polarity = "dark";
    autoEnable = true;
    image = ./wall/image.png;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-hard.yaml";
    fonts.sizes = {
      terminal = 10;
      desktop = 6;
      popups = 6;
    };

    fonts.monospace = {
      package = pkgs.nerd-fonts.blex-mono;
      name = "BlexMono Nerd Font Medium";
    };

    cursor.package = pkgs.capitaine-cursors-themed;
    cursor.name = "Capitaine Cursors (Gruvbox)";
    cursor.size = 18;
  };
}
