{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  programs.foot.enable = true;
  programs.foot.settings = {
    main = {
      term = "xterm-256color";
    };

    mouse = {
      hide-when-typing = "yes";
    };
  };

  programs.tofi.enable = true;
  programs.tofi.settings = {
    anchor = "bottom";
    width = "100%";
    height = 13;
    horizontal = true;
    font-size = lib.mkForce 8;
    prompt-text = "tofi: ";
    outline-width = 0;
    border-width = 0;
    min-input-width = 120;
    result-spacing = 10;
    padding-top = 0;
    padding-bottom = 0;
    padding-left = 0;
    padding-right = 0;
  };
  services.hypridle.enable = true;
  services.cliphist.enable = true;
  services.dunst.enable = true;
  services.dunst.settings = builtins.fromTOML (builtins.readFile ./notifier/dunst.toml);
  # programs.kanshi.enable = true;
  wayland.windowManager.hyprland.enable = true; # enable Hyprland
  wayland.windowManager.hyprland.package = null;
  wayland.windowManager.hyprland.portalPackage = null;

  wayland.windowManager.hyprland.settings = {
    animations.enabled = false;
    cursor.no_hardware_cursors = true;
    dwindle.pseudotile = true;
    dwindle.preserve_split = true;
    master.new_status = "master";

    general = {
      gaps_in = -1;
      gaps_out = [0 (-1) 0 (-1)];
      border_size = 1;
      layout = "dwindle";
      resize_on_border = false;
      allow_tearing = false;
    };

    decoration = {
      rounding = 0;
      active_opacity = 0.95;
      inactive_opacity = 0.8;
      blur = {
        enabled = false;
        size = 4;
        passes = 1;
        vibrancy = 0.17;
      };
      shadow.enabled = false;
    };

    input = {
      kb_layout = "us";
      sensitivity = 0.3;
      touchpad.natural_scroll = true;
      touchpad.scroll_factor = 0.3;
      touchpad.clickfinger_behavior = true;
    };

    gestures.workspace_swipe = true;

    "$mainMod" = "SUPER";
    bind = [
      "$mainMod, Q, exec, foot"
      "$mainMod, C, killactive,"
      "$mainMod, M, exit,"
      "$mainMod CTRL, V, togglefloating,"
      "$mainMod, H, movefocus, l"
      "$mainMod, L, movefocus, r"
      "$mainMod, K, movefocus, u"
      "$mainMod, J, movefocus, d"
      "$mainMod SHIFT, H, movewindow, l"
      "$mainMod SHIFT, J, movewindow, d"
      "$mainMod SHIFT, K, movewindow, u"
      "$mainMod SHIFT, L, movewindow, r"
      "$mainMod, 1, focusworkspaceoncurrentmonitor, 1"
      "$mainMod, 2, focusworkspaceoncurrentmonitor, 2"
      "$mainMod, 3, focusworkspaceoncurrentmonitor, 3"
      "$mainMod, 4, focusworkspaceoncurrentmonitor, 4"
      "$mainMod, 5, focusworkspaceoncurrentmonitor, 5"
      "$mainMod, 6, focusworkspaceoncurrentmonitor, 6"
      "$mainMod, 7, focusworkspaceoncurrentmonitor, 7"
      "$mainMod, 8, focusworkspaceoncurrentmonitor, 8"
      "$mainMod, 9, focusworkspaceoncurrentmonitor, 9"
      "$mainMod, 0, focusworkspaceoncurrentmonitor, 10"
      "$mainMod SHIFT, 1, movetoworkspace, 1"
      "$mainMod SHIFT, 2, movetoworkspace, 2"
      "$mainMod SHIFT, 3, movetoworkspace, 3"
      "$mainMod SHIFT, 4, movetoworkspace, 4"
      "$mainMod SHIFT, 5, movetoworkspace, 5"
      "$mainMod SHIFT, 6, movetoworkspace, 6"
      "$mainMod SHIFT, 7, movetoworkspace, 7"
      "$mainMod SHIFT, 8, movetoworkspace, 8"
      "$mainMod SHIFT, 9, movetoworkspace, 9"
      "$mainMod SHIFT, 0, movetoworkspace, 10"
      "$mainMod, B, togglespecialworkspace, magic"
      "$mainMod SHIFT, B, movetoworkspace, special:magic"
      "$mainMod, Z, togglespecialworkspace, balls"
      "$mainMod SHIFT, Z, movetoworkspace, special:balls"
      "$mainMod, D, togglespecialworkspace, discord"
      "$mainMod SHIFT, D, movetoworkspace, special:discord"
      "$mainMod CTRL, left, workspace, r-1"
      "$mainMod CTRL, right, workspace, r+1"
      "$mainMod, F, fullscreenstate, 0 2"
      "$mainMod, O, setprop, active opaque toggle"
      "$mainMod, T, togglesplit,"
      "$mainMod, SPACE, exec, pkill tofi-run || hyprctl dispatch exec \"$( tofi-run --fuzzy-match=true --drun-launch=true )\""
      "$mainMod, V, exec, pkill tofi || cliphist list | tofi | cliphist decode | wl-copy | wl-paste"
      ''$mainMod SHIFT, S, exec, grim -g "$(slurp)" - | wl-copy''
    ];
    bindel = [
      ",XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5% && ~/.config/scripts/audio"
      ",XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5% && ~/.config/scripts/audio"
      ",XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle && ~/.config/scripts/audio"
      ",XF86AudioMicMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle && ~/.config/scripts/audio"
      ",XF86MonBrightnessUp, exec, brightnessctl s 5%+ -s && ~/.config/scripts/brightness"
      ",XF86MonBrightnessDown, exec, brightnessctl s 5%- -s && ~/.config/scripts/brightness"
    ];
    bindl = [
      ", XF86AudioNext, exec, playerctl next"
      ", XF86AudioPause, exec, playerctl play-pause"
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioPrev, exec, playerctl previous"
    ];

    binde = [
      "$mainMod CTRL, H, resizeactive, -10% 0"
      "$mainMod CTRL, J, resizeactive, 0 10%"
      "$mainMod CTRL, K, resizeactive, 0 -10%"
      "$mainMod CTRL, L, resizeactive, 10% 0"
    ];
    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod CTRL, mouse:272, resizewindow"
    ];
    monitor = [
      "Virtual-1, 1920x1080, auto, 1"
      ",preferred,auto,1"
    ];

    exec-once = [
      "wl-paste --watch cliphist store"
      "wl-paste --type image --watch cliphist store"
      "dunst"
      "fcitx5"
      "hyprctl setcursor 'Capitaine Cursors (Gruvbox)' 18"
      "hyprdim"
      "sleep 0.1 && waybar"
    ];
    misc = {
      vfr = true;
    };
  };

  # Optional, hint Electron apps to use Wayland:
  home.sessionVariables.NIXOS_OZONE_WL = "1";
}
