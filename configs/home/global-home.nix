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
    devenv
    cachix
    tinymist
    fortune
    brightnessctl
  ];

  programs.bat.enable = true;

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

  home.file.fortune = {
    enable = true;
    source = ./fortune;
    target = ".config/fortune/";
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
        sha256 = "YkfLXyxwCG7lvPMpGUC93qhOyT6G5K9W+dCDtXQVi+s=";
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

  programs.emacs.enable = true;
}
