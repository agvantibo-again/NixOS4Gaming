{ config, pkgs, lib, ... }:

{
  services.resolved.enable = true;

  # services.resolved.extraConfig = ''          <---------- Uncomment
  # p1.freedns.controld.com                     <---------- This is the ControlD's free malware dns, but you can change to your own
  # DNSOverTLS=yes                              <---------- Uncomment (and/or change to your dns settings)
  '';

  networking.networkmanager.dns = lib.mkForce "systemd-resolved";

  networking.networkmanager.settings = {
    "main".rc-manager = "unmanaged";
    "dhcp".use-dns = false;
  };
}
