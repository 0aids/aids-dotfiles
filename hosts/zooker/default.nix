{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./../../configs/nixos/config-global.nix
    ./../../configs/nixos/hyprland-basic.nix
    ./../../configs/nixos/btrfs.nix
    ./../../configs/nixos/grub-base.nix
    ./../../configs/nixos/grub-extras.nix
    ./../../configs/nixos/nixos-stylix.nix
    ./../../configs/home/neovim.nix
  ];
  # Enable "Silent boot"
  boot.consoleLogLevel = 2;
  boot.initrd.verbose = false;
  networking.hostName = "zooker"; # Define your hostname.

  hardware.bluetooth.enable = true;
  services.upower.enable = true;
  services.blueman.enable = true;

  services.libinput.enable = true;

  services.undervolt = {
    enable = false;
    p1 = {
      window = 1;
      limit = 100;
    };
    p2 = {
      window = 100;
      limit = 100;
    };
  };
  hardware.graphics.enable = true;

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    open = false;
    nvidiaSettings = true;
    prime = {
      sync.enable = true;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
  services.xserver.videoDrivers = ["modesetting" "nvidia"];

  services.tlp.enable = true;

  programs.ssh.startAgent = true;

  # WARNING: DON'T MODIFY!
  system.stateVersion = "25.05"; # Did you read the comment?
}
