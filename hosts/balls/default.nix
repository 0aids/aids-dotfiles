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
    ./../../configs/nixos/nvidia.nix
    ./../../configs/home/neovim.nix
  ];
  # Enable "Silent boot"
  boot.consoleLogLevel = 2;
  boot.initrd.verbose = false;
  # video=HDMI-A-1:1920x1080@60 drm.edid_firmware=HDMI-A-1:edid/3008wfp-edid.bin
  boot.kernelParams = ["video=HDMI-A-1:1920x1080@60" "drm.edid_firmware=HDMI-A-1:edid/3008wfp-edid.bin"];
  hardware.firmware = [
    (
      pkgs.runCommand "3008wfp-edid.bin" {} ''
        mkdir -p $out/lib/firmware/edid
        cp ${./3008wfp-edid.bin} $out/lib/firmware/edid/3008wfp-edid.bin
      ''
    )
  ];
  networking.hostName = "balls"; # Define your hostname.

  programs.ssh.startAgent = true;

  # WARNING: DON'T MODIFY!
  system.stateVersion = "25.05"; # Did you read the comment?
}
