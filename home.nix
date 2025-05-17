# TODO: Splitup this configuration
{
  config,
  pkgs,
  lib,
  ...
}: {
  home.username = "aids";
  home.homeDirectory = "/home/aids";
  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.shellAliases = {
    ls = "ls --color=auto -a";
    grep = "grep --color=auto";
    pow = "upower -i /org/freedesktop/UPower/devices/battery_BAT0";
  };

  home.packages = with pkgs; [
    ghostscript # Used for previewing pdfs
  ];

  targets.genericLinux.enable = true;

  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    MANPAGER = "nvim +Man!";
  };

  programs.home-manager.enable = true;
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    settings = {
      sort_dir_first = true;
    };
    shellWrapperName = "y";
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
      ''
        tmux_open
      ''
    ];
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
        sha256 = "SAJnzXaV5l4djBgP7kNPn2g2jNUrb9OCeKqmv+Nmj9U=";
      };
    };
    gruvboxed_cat = pkgs.tmuxPlugins.mkTmuxPlugin {
      pluginName = "tmux-gruvbox";
      version = "";
      src = pkgs.fetchFromGitHub {
        owner = "z3z1ma";
        repo = "tmux-gruvbox";
        rev = "main";
        sha256 = "wBhOKM85aOcV4jD7wdyB/zXKDdhODE5k1iud+cm6Wk0=";
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
    ];
    keyMode = "vi";
    mouse = true;
    terminal = "xterm-256color";
    extraConfig = builtins.readFile ./tmux/tmux.conf;
    prefix = "C-a";
  };
}
