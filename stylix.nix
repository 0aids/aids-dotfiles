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
      desktop = 10;
      popups = 8;
    };

    fonts.monospace = {
      package = pkgs.nerd-fonts.blex-mono;
      name = "BlexMono Nerd Font Medium";
    };

    cursor.package = pkgs.capitaine-cursors-themed;
    cursor.name = "Capitaine Cursors (Gruvbox)";
    cursor.size = 18;
    targets = {
      qt.enable = true;
      qt.platform = "qtct";
      gtk.enable = true;
      # foot.enable = true;
      # nvf.enable = true;
      # tofi.enable = true;
      waybar.addCss = false;
    };
    iconTheme = {
      enable = true;
      package = pkgs.gruvbox-plus-icons;
      dark = "Gruvbox-Plus-Dark";
    };
  };
}
