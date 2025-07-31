# /etc/nixos/modules/disks/automount.nix
{ config, pkgs, ... }:

{
  fileSystems."/mnt/disk1" = {                                          # Change disk1 to the name of your disk
    device = "/dev/disk/by-uuid/00000000-0000-0000-0000-000000000000";  # Change to your disk's UUID
    fsType = "btrfs";
    options = [ "defaults" "nofail" "x-systemd.automount" ];
  };

  fileSystems."/mnt/disk2" = {                                         # Change disk1 to the name of your disk
    device = "/dev/disk/by-uuid/00000000-0000-0000-0000-000000000000"; # Change to your disk's UUID
    fsType = "btrfs";
    options = [ "defaults" "nofail" "x-systemd.automount" ];
  };

  ## Repeat the fileSystems block for any disk you need to automount

  # Polkit rule to allow users in 'wheel' group to mount internal drives without password
  environment.etc."polkit-1/rules.d/90-local-mount.rules".text = ''
    polkit.addRule(function(action, subject) {
        if (action.id == "org.freedesktop.udisks2.filesystem-mount-system" &&
            subject.isInGroup("wheel")) {
            return polkit.Result.YES;
        }
    });
  '';
}
