{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  home.packages = lib.mkAfter (with pkgs; [
    ghostscript # Used for previewing pdfs
    nwg-panel
    wl-clipboard
    grim
    slurp
    kdePackages.dolphin
    xfce.thunar
    libsixel
    hyprdim
    deepin.dde-file-manager
    vesktop
  ]);
  programs.mpv.enable = true;
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
    ];
    fcitx5.waylandFrontend = true;
    fcitx5 = {
      settings.globalOptions = {
        HotKey = {
          EnumerateWithTriggerKeys = true;
          "TriggerKeys/0" = "Control+Space";
          "EnumerateGroupForwardKeys/0" = "VoidSymbol";
          "EnumerateGroupBackwardKeys/0" = "VoidSymbol";
          "ActivateKeys/0" = "VoidSymbol";
          "DecativateKeys/0" = "VoidSymbol";
          "PrevPage/0" = "VoidSymbol";
          "NextPage/0" = "VoidSymbol";
          "PrevCandidate/0" = "Shift+Tab";
          "NextCandidate/0" = "Tab";
          "TogglePreedit/0" = "VoidSymbol";
        };
        Behaviour = {
          ActiveByDefault = false;
        };
      };
      settings.inputMethod = {
        GroupOrder."0" = "Default";
        "Groups/0" = {
          Name = "Default";
          "Default Layout" = "us";
          DefaultIM = "mozc";
        };
        "Groups/0/Items/0".Name = "keyboard-us";
        "Groups/0/Items/1".Name = "mozc";
      };
    };
  };
  home.file.vesktop-theme = {
    enable = true;
    source = ./discord/system24.css;
    target = ".config/vesktop/themes/system24.theme.css";
  };
  programs.waybar = {
    enable = true;
    settings = builtins.fromJSON (builtins.readFile ./statusbar/waybar.json);
    style = lib.mkAfter (builtins.readFile ./statusbar/waybar.css);
  };
  home.file.start_page = {
    enable = true;
    source = ./start_page;
    target = ".config/start_page/";
  };
  programs.qutebrowser.enable = true;
  programs.qutebrowser.greasemonkey = [
    (
      pkgs.writeText
      "youtube-block.js"
      (builtins.readFile ./qutebrowser/youtube-block.js)
    )
    (
      pkgs.writeText
      "darkmode-blacklist.js"
      (builtins.readFile ./qutebrowser/darkmode-blacklist.js)
    )
  ];
  programs.qutebrowser.settings = {
    colors.webpage.darkmode.enabled = true;
    colors.webpage.bg = "#101010";
    fonts.default_size = lib.mkForce "7pt";
    tabs.show = "switching";
    tabs.show_switching_delay = 2000;
    tabs.position = "top";
    completion.shrink = true;
    url.start_pages = "~/.config/start_page/index.html";
    completion.min_chars = 5;
    completion.delay = 200;
  };
  # NOTE: Duck duck go allows for better moving around in the search page.
  programs.qutebrowser.searchEngines = {"DEFAULT" = "https://google.com/search?hl=en&q={}";};
  programs.qutebrowser.keyBindings = {
    normal = {
      "J" = "tab-prev";
      "K" = "tab-next";
    };
    insert = {
      "<Escape>" = "mode-leave ;; jseval -q document.activeElement.blur()";
    };
  };
  # Should come with plugins
  programs.zathura.enable = true;
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
}
