# Everything required for the based hyprland config
{
  config,
  lib,
  pkgs,
  ...
}: {
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [xdg-desktop-portal-hyprland];
  };
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };
  environment.systemPackages = lib.mkAfter (with pkgs; [
    hyprpolkitagent
    pulseaudioFull
  ]);
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    nerd-fonts.hack
    nerd-fonts."m+"
    nerd-fonts.tinos
    nerd-fonts.fira-mono
    nerd-fonts.jetbrains-mono
  ];
  programs.kdeconnect.enable = true;
  programs.chromium.enable = true;
}
