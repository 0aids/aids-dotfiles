{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: let
  sharedStylix = import ./stylix-main.nix {
    inherit pkgs;
    inherit config;
  };
in {
  stylix =
    sharedStylix
    // {
      targets = {
        grub.enable = false;
        console.enable = false;
        plymouth.enable = false;
      };
    };
}
