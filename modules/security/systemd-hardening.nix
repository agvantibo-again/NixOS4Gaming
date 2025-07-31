# /etc/nixos/modules/security/systemd-hardening.nix
{ config, pkgs, lib, ... }:

{
  # Systemd Manager Global Configuration (for accounting and limits)
  # systemd.enableUnifiedCgroupHierarchy is now implicitly true and removed
  systemd.extraConfig = ''
    DefaultCPUAccounting=yes
    DefaultIOAccounting=yes
    DefaultBlockIOAccounting=yes
    DefaultMemoryAccounting=yes
    DefaultTasksAccounting=yes
    DefaultLimitNOFILE=524288
    DefaultLimitNPROC=524288
  '';

  # Kernel Parameter Hardening (sysctl)
  boot.kernel.sysctl = {
    "fs.protected_regular" = 2;
    "fs.protected_fifos" = 2;

    "kernel.randomize_va_space" = 2;

    "fs.suid_dumpable" = 0;

    "net.ipv4.conf.all.rp_filter" = 1;
    "net.ipv4.conf.default.rp_filter" = 1;

    "net.ipv4.conf.all.accept_source_route" = 0;
    "net.ipv4.conf.default.accept_source_route" = 0;

    "net.ipv4.conf.all.accept_redirects" = 0;
    "net.ipv4.conf.default.accept_redirects" = 0;
    "net.ipv6.conf.all.accept_redirects" = 0;
    "net.ipv6.conf.default.accept_redirects" = 0;

    "net.ipv4.icmp_echo_ignore_broadcasts" = 1;

    "net.ipv4.conf.all.log_martians" = 1;
    "net.ipv4.conf.default.log_martians" = 1;

    "kernel.sysrq" = 0;
    # NOT setting "kernel.unprivileged_userns_clone = 0;" to ensure Flatpak works.
  };

  # Ensure firewall is enabled and default policy is reasonable
  networking.firewall.enable = true;
  # networking.firewall.allowedTCPPorts = [ 22 ]; # For SSH if needed
}
