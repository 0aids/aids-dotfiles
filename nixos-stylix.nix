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
    };
}
