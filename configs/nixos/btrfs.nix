{
  pkgs,
  config,
  lib,
  ...
}: {
  # Assumes the standard file system structure
  fileSystems = {
    "/".options = ["compress=zstd"];
    "/home".options = ["compress=zstd"];
    "/nix".options = ["compress=zstd" "noatime"];
  };
  #############
  # SNAPSHOTS #
  #############
  # Remember to add the subvolume .snapshots in the home directory.
  # Use: btrfs subvolume create .snapshots
  # Also make sure that its in the home directory, or wherever the directory of the config lies.
  services.snapper.persistentTimer = true;
  services.snapper.configs = {
    home = {
      SUBVOLUME = "/home";
      ALLOW_USERS = ["aids"];
      TIMELINE_CREATE = true;
      TIMELINE_CLEANUP = true;
      TIMELINE_LIMIT_HOURLY = 10;
      TIMELINE_LIMIT_DAILY = 7;
      TIMELINE_LIMIT_WEEKLY = 3;
      TIMELINE_LIMIT_MONTHLY = 1;
      TIMELINE_LIMIT_YEARLY = 0;
    };
  };
}
