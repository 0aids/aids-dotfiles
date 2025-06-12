{
  config,
  lib,
  pkgs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;
  documentation.enable = true;
  documentation.man.enable = true;
  documentation.man.generateCaches = false; #This makes rebuilding take forever.
  documentation.doc.enable = true;
  documentation.dev.enable = true;
  documentation.info.enable = true;
  documentation.nixos.enable = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings.trusted-users = ["root" "aids"];

  services.keyd.enable = true;
  services.keyd.keyboards.default.settings = {
    main = {
      capslock = ''lettermod(meta, esc, 10, 200)'';
      s = ''lettermod(alt, s, 10, 200)'';
      d = ''lettermod(control, d, 10, 200)'';
      f = ''lettermod(shift, f, 10, 200)'';
      j = ''lettermod(shift, j, 10, 200)'';
      k = ''lettermod(control, k, 10, 200)'';
      l = ''lettermod(alt, l, 10, 200)'';
      "'" = ''lettermod(meta, ', 10, 200)'';
      leftshift = "backspace";
      rightshift = "oneshot(shift)";
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
