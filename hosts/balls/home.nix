{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./../../configs/home/global-home.nix
    ./../../configs/home/home-stylix.nix
    ./../../configs/home/wm-home.nix
    ./../../configs/home/hyprland.nix
  ];
  # personal config goes here:

  wayland.windowManager.hyprland.settings = lib.mkAfter {
    input = lib.mkForce {
      kb_layout = "us";
      sensitivity = -0.3;
      touchpad.natural_scroll = true;
      touchpad.scroll_factor = 0.3;
      touchpad.clickfinger_behavior = true;
    };
    monitor = lib.mkAfter [
      "DVI-D-1,preferred,+1920x-200,auto, transform, 1, bitdepth, 8"
      "HDMI-A-1,1920x1200,0x0,auto"
      ",preferred,auto,auto"
    ];
  };
}
