# /etc/nixos/virtualisation.nix
{ pkgs, systemUsername, ... }:

{
  # Enable the libvirt daemon
  virtualisation.libvirtd.enable = true;

  # Install necessary packages
  environment.systemPackages = with pkgs; [
    virt-manager
    qemu_kvm
  ];

  # Add your user to the 'libvirtd' group
  users.users.${systemUsername}.extraGroups = [ "libvirtd" ];
}
