# Grub extras, styling + plymouth
{
  config,
  lib,
  pkgs,
  ...
}: {
  boot.loader.grub.theme = pkgs.minimal-grub-theme;
  boot.loader.grub.backgroundColor = "#000000";
  boot.loader.grub.splashImage = null;
  services.greetd.enable = true;
  services.greetd.settings = {
    default_session = {
      command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd Hyprland";
    };
  };
  services.greetd.package = pkgs.greetd.tuigreet;
  boot.plymouth = {
    enable = true;
    themePackages = with pkgs; [plymouth-blahaj-theme];
    theme = "blahaj";
  };
}
