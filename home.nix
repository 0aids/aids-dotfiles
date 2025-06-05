# TODO: Splitup this configuration
{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  home.username = "aids";
  home.homeDirectory = "/home/aids";
  home.stateVersion = "25.05"; # Please read the comment before changing.
  # Adding scripts to path
  home.sessionPath = [
    "$HOME/.config/scripts"
  ];
  home.shell.enableBashIntegration = true;

  # Ip is to paste images into cwd.
  home.shellAliases = {
    ls = "ls --color=auto";
    grep = "grep --color=auto";
    pow = "upower -i /org/freedesktop/UPower/devices/battery_BAT0";
    hrs = "home-manager switch --flake ~/.dotfiles/";
    nrs = "sudo nixos-rebuild switch --flake ~/.dotfiles/";
    cat = "bat";
    pd = "eval \"$(tmux showenv -s DISPLAY)\"";
  };

  home.packages = with pkgs; [
    ghostscript # Used for previewing pdfs
    nwg-panel
    wl-clipboard
    grim
    slurp
    kdePackages.dolphin
    devenv
    cachix
    xfce.thunar
    libsixel
    hyprdim
    tinymist
    deepin.dde-file-manager
    fortune
    brightnessctl
    vesktop
  ];

  programs.mpv.enable = true;
  programs.bat.enable = true;
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
  targets.genericLinux.enable = true;

  home.pointerCursor.enable = true;
  programs.gh = {
    enable = true;
  };

  home.file.scripts = {
    enable = true;
    source = ./scripts;
    target = ".config/scripts/";
  };

  home.file.vesktop-theme = {
    enable = true;
    source = ./discord/system24.css;
    target = ".config/vesktop/themes/system24.theme.css";
  };
  home.file.fortune = {
    enable = true;
    source = ./fortune;
    target = ".config/fortune/";
  };

  programs.waybar = {
    enable = true;
    settings = builtins.fromJSON (builtins.readFile ./statusbar/waybar.json);
    style = lib.mkAfter (builtins.readFile ./statusbar/waybar.css);
  };

  qt = {
    # style.name = lib.mkForce "kvantum";
  };

  home.file.start_page = {
    enable = true;
    source = ./start_page;
    target = ".config/start_page/";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    MANPAGER = "nvim +Man!";
  };

  programs.home-manager.enable = true;
  # programs.dconf.enable = true;
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    settings = {
      sort_dir_first = true;
    };
  };

  programs.bash = {
    enable = true;
    bashrcExtra = lib.strings.concatStrings [
      ''
        FZF_CTRL_T_COMMAND=""
        FZF_ALT_C_COMMAND=""
      ''
      (builtins.readFile
        ./bash/tmux_bashrc.sh)
    ];
    # profileExtra = builtins.readFile ./bash/profile;
  };
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    settings = builtins.fromTOML (builtins.readFile ./bash/starship.toml);
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
  };
  programs.git = {
    enable = true;
    userName = "0aids";
    userEmail = "aidanlldanu@gmail.com";
  };

  programs.zoxide.enable = true;
  programs.zoxide.enableBashIntegration = true;
  programs.zoxide.options = ["--cmd cd"];

  programs.tmux = let
    smart_splits = pkgs.tmuxPlugins.mkTmuxPlugin {
      pluginName = "smart-splits";
      version = "2.0.1";
      src = pkgs.fetchFromGitHub {
        owner = "mrjones2014";
        repo = "smart-splits.nvim";
        rev = "master";
        sha256 = "hcGjCWm50LZu2NOxTqxZkZqPEpcn0hfVipeYrDkN/3g=";
      };
    };
  in {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = smart_splits;
        extraConfig = "";
      }
      # tmux-powerline
      {
        plugin = gruvbox;
        extraConfig = "set -g @tmux-gruvbox 'dark' # or 'dark256', 'light', 'light256'";
      }
      {
        plugin = tmux-sessionx;
        extraConfig = "set -g @sessionx-bind '/'";
      }
      {
        plugin = resurrect;
        extraConfig = "";
      }
      {
        plugin = continuum;
        extraConfig = "set -g @continuum-restore 'on'";
      }
    ];
    keyMode = "vi";
    mouse = true;
    terminal = "xterm-256color";
    extraConfig = builtins.readFile ./tmux/tmux.conf;
    prefix = "C-a";
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

  programs.btop = {
    enable = true;
    settings = {
      vim_keys = true;
      update_ms = 1000;
    };
  };
  programs.ripgrep.enable = true;

  services.syncthing = {
    enable = true;
    overrideDevices = false;
    overrideFolders = false;
  };
  # Should come with plugins
  programs.zathura.enable = true;

  programs.emacs.enable = true;
}
