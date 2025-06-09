{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./../../configs/home/global-home.nix
    ./../../configs/home/home-stylix.nix
    ./../../configs/home/wm-home.nix
    ./../../configs/home/hyprland.nix
  ];
  wayland.windowManager.hyprland.settings = lib.mkAfter {
    input = lib.mkForce {
      kb_layout = "us";
      sensitivity = 0.3;
      touchpad.natural_scroll = true;
      touchpad.scroll_factor = 0.3;
      touchpad.clickfinger_behavior = true;
    };
    monitor = lib.mkAfter [
      "eDP-1, preferred, auto, 1"
    ];
  };
}
