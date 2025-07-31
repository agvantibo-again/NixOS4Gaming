# /etc/nixos/modules/security/secure-boot.nix
{ pkgs, lib, ... }:

{
  environment.systemPackages = [
    pkgs.sbctl
  ];

  # Force disable systemd-boot to let Lanzaboote take over
  boot.loader.systemd-boot.enable = lib.mkForce false;

  # Configure Lanzaboote
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };
}
