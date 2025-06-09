{
  config,
  lib,
  pkgs,
  ...
}: {
  documentation.enable = true;
  documentation.man.enable = true;
  documentation.man.generateCaches = true;
  documentation.doc.enable = true;
  documentation.dev.enable = true;
  documentation.info.enable = true;
  documentation.nixos.enable = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings.trusted-users = ["root" "aids"];

  services.keyd.enable = true;
  services.keyd.keyboards.default.settings = {
    main = {
      capslock = "esc";
    };
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;
  time.timeZone = "Pacific/Auckland";
  security.rtkit.enable = true;
  users.users.aids = {
    isNormalUser = true;
    extraGroups = ["wheel" "audio"]; # Enable ‘sudo’ for the user.
  };

  programs.dconf.enable = true;
  environment.systemPackages = with pkgs; [
    neovim
    file
    linux-manual
    man-pages
    man-pages-posix
  ];
  # Enable the OpenSSH daemon.
  programs.ssh.startAgent = true;
  services.openssh = {
    enable = true;
    settings = {
      AllowUsers = ["aids"];
      PasswordAuthentication = true;
      PermitRootLogin = "yes";
    };
  };
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.
}
