# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, systemUsername, systemHostname, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/flatpak/flatpak-packages.nix        # <------- Let's you install flatpaks declaratively
      ./modules/virtualisation/virtualisation.nix   # <------- Virtualization with USB passthrough enabled and Virtual Machine Manager installed
      # ./modules/disks/automount.nix               # <------- Edit the file and uncomment this line if you want your disks to automount
      # ./modules/security/systemd-hardening.nix      <------- Before you turn this on, rebuild the system once and update it. Then turn this on if you want some extra security features.
      # ./modules/network/dns.nix                     <------- Can be activated if you want to change your DNS, please go to dns.nix to use your dns parameters, then uncomment this line
    ];

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader. Leave as is, don't change to grub or SECURE BOOT WON'T WORK AND YOU MIGHT NOT BE ABLE TO BOOT YOUR OPERATING SYSTEM.
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 5;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Turn on ntsync
  boot.initrd.kernelModules = [ "ntsync" ]; # Proton GE works with NTSYNC out of the box = better gaming performance with no effort

  networking.hostName = systemHostname;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "gb";   # <------- Change to your layout
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "uk";  # <------- Change to your country

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${systemUsername} = {
    isNormalUser = true;
    description = "${systemUsername}";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
  };

  # Home Manager global configuration for this NixOS system
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  # This links your system user to your home.nix configuration
  home-manager.users.${systemUsername} = import ./home.nix { inherit config pkgs lib systemUsername systemHostname; };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  git
  ];

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  # nixpkgs.config.allowUnfree = true;   <--------- This is turned on in flake.nix

  # Enable Flatpak
  services.flatpak.enable = true;

  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;

  hardware.graphics = {             # Needed for Steam
    enable = true;                  # Needed for Steam
    enable32Bit = true;             # Needed for Steam and DaVinci Resolve
    extraPackages = with pkgs; [    # Needed for Steam and DaVinci Resolve
    rocmPackages.clr.icd            # Needed for Steam and DaVinci Resolve
    ];                              # Needed for Steam and DaVinci Resolve
  };

  services.xserver.videoDrivers = ["amdgpu"]; # Needed for Steam

  # Garbage Collection - cleans up your generations/snapshots periodically and optimizes space usage
  nix.gc = {
  automatic = true;
  dates = "daily"; # or "weekly", "monthly"
  options = "--delete-older-than 7d"; # Keep generations from the last 7 days
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
