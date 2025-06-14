{
  config,
  lib,
  pkgs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;
  nix.settings.substituters = [
    "https://nix-community.cachix.org"
  ];
  nix.settings.trusted-public-keys = [
    # Compare to the key published at https://nix-community.org/cache
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  ];

  nixpkgs.config.cudaSupport = true;
  nixpkgs.config.allowUnfreePredicate = p:
    builtins.all (
      license:
        license.free
        || builtins.elem license.shortName [
          "CUDA EULA"
          "cuDNN EULA"
          "cuTENSOR EULA"
          "NVidia OptiX EULA"
        ]
    ) (
      if builtins.isList p.meta.license
      then p.meta.license
      else [p.meta.license]
    );
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
      capslock = ''overloadt2(meta, esc, 200)'';
      s = ''overloadt2(alt, s, 200)'';
      d = ''overloadt2(control, d, 200)'';
      f = ''overloadt2(shift, f, 200)'';
      j = ''overloadt2(shift, j, 200)'';
      k = ''overloadt2(control, k, 200)'';
      l = ''overloadt2(alt, l, 200)'';
      "'" = ''overloadt2(meta, ', 200)'';
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
