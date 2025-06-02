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
  services.hypridle.settings = {
    general = {
      lock_cmd = "pidof hyprlock || hyprlock"; # avoid starting multiple hyprlock instances.
      before_sleep_cmd = "loginctl lock-session"; # lock before suspend.
      after_sleep_cmd = "hyprctl dispatch dpms on"; # to avoid having to press a key twice to turn on the display.
    };

    listener = [
      {
        timeout = 60; # 2.5min.
        on-timeout = "brightnessctl -s set 40"; # set monitor backlight to minimum, avoid 0 on OLED monitor.
        on-resume = "brightnessctl -r"; # monitor backlight restore.
      }

      {
        timeout = 300; # 5min
        on-timeout = "loginctl lock-session"; # lock screen when timeout has passed
      }

      {
        timeout = 330; # 5.5min
        on-timeout = "hyprctl dispatch dpms off"; # screen off when timeout has passed
        on-resume = "hyprctl dispatch dpms on && brightnessctl -r"; # screen on when activity is detected after timeout has fired.
      }

      {
        timeout = 1800; # 30min
        on-timeout = "systemctl suspend"; # suspend pc
      }
    ];
  };
  services.cliphist.enable = true;
  services.dunst.enable = true;
  # services.dunst.settings = builtins.fromTOML (builtins.readFile ./notifier/dunst.toml);
  services.dunst.settings = {
    global = {
      alignment = "center";
      allow_markup = true;
      bounce_freq = 0;
      follow = "mouse";
      format = "<b>%s</b>\n%b";
      frame_width = 0;
      height = "(0, 150)";
      horizontal_padding = 4;
      idle_threshold = 120;
      ignore_newline = false;
      indicate_hidden = true;
      line_height = 0;
      progress_bar_height = 5;
      progress_bar_frame_width = 0;
      highlight = "#${config.lib.stylix.colors.base05}";
      markup = "full";
      monitor = 0;
      offset = 5;
      origin = "bottom-center";
      padding = 2;
      separator_height = 2;
      show_age_threshold = 60;
      sort = true;
      font = lib.mkForce "Monospace 8";
      startup_notification = false;
      sticky_history = true;
      transparency = 1;
      width = "(0, 400)";
      word_wrap = true;
    };
    urgency_critical = {timeout = 0;};
    urgency_low = {timeout = 1;};
    urgency_normal = {timeout = 3;};
  };
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
      "$mainMod, SPACE, exec, pkill tofi-drun || hyprctl dispatch exec \"$( tofi-drun --fuzzy-match=true --drun-launch=true )\""
      "$mainMod, V, exec, pkill tofi || cliphist list | tofi | cliphist decode | wl-copy | wl-paste"
      # ''$mainMod CTRL, Z, exec, ~/.config/scripts/toggle-gaps''
      ''$mainMod SHIFT, S, exec, grim -g "$(slurp)" - | wl-copy''
      ''$mainMod, BACKSPACE, exec, ~/.config/scripts/tofi-power-menu''
      "$mainMod, DELETE, exec, ~/.config/scripts/toggle-idle"
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
      "systemctl --user enable --now hyprpolkitagent.service"
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
  # Submap keymaps in this file
  wayland.windowManager.hyprland.extraConfig = builtins.readFile ./hypr/hyprland-extra.conf;

  # Optional, hint Electron apps to use Wayland:
  home.sessionVariables.NIXOS_OZONE_WL = "1";

  programs.hyprlock.enable = true;
  programs.hyprlock.settings = lib.mkMerge [
    {
      general = {
        disable_loading_bar = true;
        grace = 0;
        hide_cursor = true;
        no_fade_in = false;
      };

      background = lib.mkMerge [
        {
          path = lib.mkForce "screenshot";
          contrast = 0.9;
          noise = 0.4;
          brightness = 0.4;
          blur_passes = 2;
          blur_size = 5;
          vibrancy = 0.1;
          vibrancy_darkness = 0.3;
        }
      ];

      input-field = lib.mkMerge [
        {
          size = "200, 40";
          position = "0, -80";
          monitor = "";
          rounding = 0;
          inner_color = lib.mkForce "rgba(${config.lib.stylix.colors.base00}50)";
          outer_color = lib.mkForce "rgba(${config.lib.stylix.colors.base00}50)";
          fail_color = lib.mkForce "rgba(${config.lib.stylix.colors.base08}50)";
          check_color = lib.mkForce "rgba(${config.lib.stylix.colors.base0D}50)";
          font_color = lib.mkForce "rgba(${config.lib.stylix.colors.base05}80)";
          font_family = lib.mkForce "JetBrainsMono Nerd Font";
          fail_timeout = 150;
          dots_center = true;
          dots_size = 0.2;
          fade_on_empty = false;
          outline_thickness = 0;
          placeholder_text = ''Password...'';
          shadow_passes = 0;
        }
      ];
    }
  ];
  programs.hyprlock.sourceFirst = false;
  programs.hyprlock.extraConfig = ''
    label {
      monitor =
      text = <span foreground='##${config.lib.stylix.colors.base04}60'><b>$TIME</b></span>
      font_size = 100
      font_family = JetBrainsMono Nerd Font
      position = 0, 75
      halign = center
      valign = center
    }

    label {
      # color = "rgba(${config.lib.stylix.colors.base04}1E)"
      text = cmd[update:100000] echo "<span foreground='##${config.lib.stylix.colors.base04}60'>$(date +'%a %D')</span>"
      font_size = 20
      font_family = JetBrainsMono Nerd Font
      position = 0, -15
      halign = center
      valign = center
    }
  '';
}
