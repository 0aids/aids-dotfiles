{
  config,
  lib,
  pkgs,
  ...
}: {
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
}
