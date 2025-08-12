{
  config,
  pkgs,
  lib,
  ...
}:

{
  services.resolved.enable = true;

  # Change details with your DNS
  services.resolved.extraConfig = ''
    DNS=
    DNSOverTLS=yes
  '';

  networking.networkmanager.dns = lib.mkForce "systemd-resolved";

  networking.networkmanager.settings = {
    "main".rc-manager = "unmanaged";
    "dhcp".use-dns = false;
  };
}
