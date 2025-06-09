# The base grub configuration for all setups
{
  config,
  lib,
  pkgs,
  ...
}: {
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.efi.canTouchEfiVariables = true;
}
