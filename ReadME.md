# NixOS for Gaming and Production (for AMD)

These are my personal configuration files. I decided to share them in case other people want a jump-start for their own gaming machine. As I am new to NixOS, this might not be the most efficient code you have ever seen, but the set up works. Feel free to tweak it for your own use. Just install NixOS (I use the graphical installer) and then you can use these files. I use KDE so bear this in mind.
**There are a few things to note before you dump them into your /etc/nixos folder though, so read these instructions and follow them carefully!**

## IMPORTANT: Change your username and hostname in the flake.nix file!
The configuration will not work if you don't do this. I marked where you change them in the file itself. Once you have done this and followed the instructions below, run the `sudo nixos-rebuild switch --upgrade` command as your system is not yet using flakes (it will be once these configurations files are active).

Once you have installed NixOS via the graphical installer (from the NixOS website), you can drop these files in /etc/nixos/ 
For the very first time, even though you dropped my files, your flake will not be enabled, so you will need to run a `nixos build-switch` command first to enable flakes. From then on you can use `nixos-rebuild switch --flake .#nixos` to rebuild with flake enabled. I believe that the default hostname when you install will be nixos, buf if not, you have to change the `#nixos` part to your hostname.

## What's Included


### Gaming packages
**Steam** of course. I am using the native version here to ease of integration (not the flapak). Also **Proton Plus** so you can install your favourite custom Proton versions (for example Proton GE or Cachy Proton), **Lutris**, **MangoHud** (and **MangoJuce** to configure it), **Discord** (to chat to your friends while playing).

### Declarative Flatpak setup
If you just enable flatpaks in NixOS you will have to install them as you would in any other distro, which is not a declarative way of doing it. However, thanks to gmodena we can install Flatpaks declaratively: https://github.com/gmodena/nix-flatpak

Why Flatpak? Sandboxing and proprietary software. I like to sandbox my browser and most internet-facing software. I didn't sandbox Steam for ease of integration with things such as MangoHud (your performance overlay). Other software uses Flatpak as their official means of distribution such as OBS. I also provided you with Flatseal so you can easily change flatpak permissions and Warehouse so you can snapshot and clean up old data. Blame the Universal Blue team for me liking Flatpak ;)
Bear in mind that you can still install nix packages the normal way, the Flatpaks are an addition.

### OBS and DaVinci-Resolve
If you are a content creator who likes to share their gaming-related content.

### Other packages
Just have a look at the flatpak module and home-manager.

## Other features

### Flake-enabled
So you can use flakes from other users.

### Unstable channel
For the latest packages, but be aware that there might be regressions as with all rolling releases.

### Home Manager
If you wish to manage software that doesn't need to be installed system-wide in a centralised manner. As well as your dotfiles.

### The Lanzaboote secure boot set up 
I included sbctl, which is required to generate and sign your own keys, and lanzaboote, which is required to enable secure boot. If you want to enable secure boot, please follow the tutorial in this link: https://github.com/nix-community/lanzaboote 

If you don't want secure boot, then just delete the Lanzaboote references in the flake.nix and configuration.nix. Then go to the modules folder and delete "security".

### A custom DNS configuration
I use a DNS to have an extra line of defense against malware. You need to go to the configuration.nix file and uncomment `./modules/network/dns.nix` inside `imports` if you want to use a custom DNS. Then go to modiles > network dns.nix and update it with your dns information.

### Automount template
This should be disk agnostic, if you don't want automount, delete the import in configuration.nix as well as the disks folder inside modules.

### Virtualization turned on and Virtual Machine Manager
If you want to try other distros or you need to access Windows to update those pesky peripherals that cannot be updated on Linux, this will have you covered. When you first start Virtual Machine Manager it might tell you you do not have a connection. Just go to **File > Add Connection**, then you should be ready to install your virtual machine.

### Rebuild NixOS.desktop and Update NixOS.desktop
While you can create aliases so you could just do it all in terminal, if you are a GUI type-of person I made these two desktop icons so you can update and rebuild your system without having to retype the command every time. Just place them on your desktop and/or in `/home/.local/share/applications` if you want them to also show up in your application menu. Rebuild is for when you make changes to your configuration. Update will update your packages and also rebuild.

## That's it folks!
As I said at the beginning these are just my own configuraton files which I modified for other people's use. I tried to leave comments where action would be necessary to turn features on or off. 

I don't pretend to know enough to be able to help with troubleshooting, but hopefully this video by Vimjoyer **Is NixOS The Best Gaming Distro** might help (he also has instructions for Nvidia): https://www.youtube.com/watch?v=qlfm3MEbqYA

His channel is probably one of the best NixOS Channels around.

I also suggest watching this video series by tony for general NixOS knowledge:

- **How to Install Customize and NixOS Linux:** https://youtu.be/lUB2rwDUm5A?si=DRc2Wegs8m1-nvk0
- **How to use NixOS Home Manager:** https://youtu.be/bFmvnJVd5yQ?si=hrMM7zITolmTOT9P
- **How to use NixOS Flakes:** https://youtu.be/v5RK3oNRiNY?si=uoFImHG31CWuZMbu

If you want a fully fledged install it and forget it operating system image on NixOS I suggest **GLF OS** although it is still in beta: https://www.gaminglinux.fr/glf-os/en/ 

You can also use **Bazzite** if you want a batteries-included distribution with similar rollback and immutability features to NixOS (at least in practice, they are a very different implementation of immutability). You will not be left wanting and it is one of the most solid and ecompassing gaming distros out there. Every time I look at their project they added some killer features, for example, you can download the mesa-git drivers to a folder (mesa-git are the latest, bleeding edge drivers that have yet to be tested), and only have Steam games use them, while your system is still on the stable drivers. And you do that with one command line **ujust mesa-git**. My own NixOS configuration took a lot of inspiration from that project. Here is their website: https://bazzite.gg

If you like Arch (btw) then there are CachyOS or Garuda.

These are just a few of the gaming distros out there, and they are all ready-to-go and easy to use. They are all an easier starting point than my configuration files.

