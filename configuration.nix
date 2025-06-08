# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    # ./nvidia.nix
  ];

  documentation.enable = true;
  documentation.man.enable = true;
  documentation.man.generateCaches = true;
  documentation.doc.enable = true;
  documentation.dev.enable = true;
  documentation.info.enable = true;
  documentation.nixos.enable = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings.trusted-users = ["root" "aids"];
  boot.loader.grub.device = "nodev";
  boot.loader.grub.theme = pkgs.minimal-grub-theme;
  boot.loader.grub.backgroundColor = "#000000";
  boot.loader.grub.splashImage = null;
  boot.consoleLogLevel = 2;
  # Enable "Silent boot"
  boot.initrd.verbose = false;
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.efi.canTouchEfiVariables = true;
  services.greetd.enable = true;
  services.greetd.settings = {
    default_session = {
      command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd Hyprland";
    };
  };
  services.greetd.package = pkgs.greetd.tuigreet;
  boot.plymouth = {
    enable = true;
    themePackages = with pkgs; [plymouth-blahaj-theme];
    theme = "blahaj";
  };

  fileSystems = {
    "/".options = ["compress=zstd"];
    "/home".options = ["compress=zstd"];
    "/nix".options = ["compress=zstd" "noatime"];
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "zooker"; # Define your hostname.

  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  time.timeZone = "Pacific/Auckland";

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  hardware.bluetooth.enable = true;
  services.upower.enable = true;
  services.blueman.enable = true;
  services.keyd.enable = true;
  services.keyd.keyboards.default.settings = {
    main = {
      capslock = "esc";
    };
  };

  services.libinput.enable = true;

  users.users.aids = {
    isNormalUser = true;
    extraGroups = ["wheel" "audio"]; # Enable ‘sudo’ for the user.
  };

  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    neovim
    hyprpolkitagent
    pulseaudioFull
    file
    linux-manual
    man-pages
    man-pages-posix
  ];
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    nerd-fonts.hack
    nerd-fonts."m+"
    nerd-fonts.tinos
    nerd-fonts.fira-mono
    nerd-fonts.jetbrains-mono
  ];
  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      AllowUsers = ["aids"];
      PasswordAuthentication = true;
      PermitRootLogin = "yes";
    };
  };

  services.undervolt = {
    enable = true;
    p1 = {
      window = 1;
      limit = 100;
    };
    p2 = {
      window = 100;
      limit = 100;
    };
  };

  services.tlp.enable = true;

  programs.ssh.startAgent = true;
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [xdg-desktop-portal-hyprland];
  };
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
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

  ########
  # VFIO #
  ########
  boot.kernelModules = [
    "vfio_pci"
    "vfio"
    "vfio_iommu_type1"
    "vfio_virqfd"

    "nvidia"
    "nvidia_modeset"
    "nvidia_uvm"
    "nvidia_drm"
  ];
  boot.blacklistedKernelModules = ["nouveau"];
  boot.kernelParams = [
    "quiet"
    "splash"
    "intel_iommu=on"
    "vfio-pci.ids=10de:1cbb,10de:0fb9"
  ];
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["aids"];

  virtualisation.libvirtd = {
    enable = false;

    qemu = {
      package = pkgs.qemu_kvm;

      ovmf.enable = true;

      ovmf.packages = [pkgs.OVMFFull.fd];

      swtpm.enable = true;

      runAsRoot = false;
    };
  };
  virtualisation.spiceUSBRedirection.enable = true;

  # WARNING: DON'T MODIFY!
  system.stateVersion = "25.05"; # Did you read the comment?
}
