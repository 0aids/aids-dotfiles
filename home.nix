# TODO: Splitup this configuration
{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  home.username = "nix-aids";
  home.homeDirectory = "/home/nix-aids";
  home.stateVersion = "25.05"; # Please read the comment before changing.

  home.shellAliases = {
    ls = "ls --color=auto -a";
    grep = "grep --color=auto";
    pow = "upower -i /org/freedesktop/UPower/devices/battery_BAT0";
    hrs = "home-manager switch --flake ~/.dotfiles/";
    nrs = "sudo nixos-rebuild switch --flake ~/.dotfiles/";
  };

  home.packages = with pkgs; [
    ghostscript # Used for previewing pdfs
    nwg-panel
    wl-clipboard
    grim
    slurp
    kdePackages.dolphin
    xfce.thunar
    libsixel
    hyprdim
    tinymist
    deepin.dde-file-manager
    fortune
  ];

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

  home.file.nwg-panel-style = {
    enable = true;
    source = ./statusbar/nwg-panel-style.css;
    target = ".config/nwg-panel/style.css";
  };
  home.file.nwg-panel-config = {
    enable = true;
    source = ./statusbar/nwg-panel-config.json;
    target = ".config/nwg-panel/config";
  };

  home.file.scripts = {
    enable = true;
    source = ./scripts;
    target = ".config/scripts/";
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

  home.file = {
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

  programs.tmux = let
    smart_splits = pkgs.tmuxPlugins.mkTmuxPlugin {
      pluginName = "smart-splits";
      version = "2.0.1";
      src = pkgs.fetchFromGitHub {
        owner = "mrjones2014";
        repo = "smart-splits.nvim";
        rev = "master";
        sha256 = "f9LmtN2cR40A+97mebBgjHwXfYCz/CNx4u5z180DwxM=";
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
  };
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
}
