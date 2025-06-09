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
  ];
  # Enable "Silent boot"
  boot.consoleLogLevel = 2;
  boot.initrd.verbose = false;
  networking.hostName = "balls"; # Define your hostname.

  programs.ssh.startAgent = true;

  # WARNING: DON'T MODIFY!
  system.stateVersion = "25.05"; # Did you read the comment?
}
