{lib, config, pkgs, ... }:
{

  imports = [
    ../modules/environment.nix
    ../modules/locale.nix
    ../modules/nix.nix
    ../modules/programs.nix
    ../modules/virtualisation.nix
  ];

  modules.hosts.environment.enable = true;
  modules.hosts.locale.enable = true;
  modules.hosts.nix.enable = true;
  modules.hosts.programs.enable = true;
  modules.hosts.virtualisation.docker.enable = true;

  hardware = {
    enableRedistributableFirmware = true;
    raspberry-pi."4".apply-overlays-dtmerge.enable = true;
    deviceTree = {
      enable = true;
      filter = "*rpi-4-*.dtb";
    };
  };

  console.enable = true;

  boot = {
    # https://docs.syncthing.net/users/faq.html#inotify-limits
    kernel.sysctl = {
      "fs.inotify.max_user_watches" = 204800;
    };
    kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;
    initrd.availableKernelModules = [ "xhci_pci" "usbhid" "usb_storage" ];
    kernelParams = [
      "usb-storage.quirks=152d:0562:u,152d:2329:u,14cd:1212"
      "cgroup_enable=cpuset" "cgroup_enable=memory" "cgroup_memory=1" "swapaccount=1"
    ];
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
  };

  documentation.nixos.enable = false;

  networking = {
    networkmanager.enable = true;
    hostName = "raspberrypi";
    firewall = {
      enable = true;
      allowedTCPPorts = [
        80
        443
        50000
        50001
        51413
        22000
        8080
      ];
      allowedUDPPorts = [
        51413
        22000
        21027
        51820
        10001
        3478
      ];
    };
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };

  users = {
    users."pi" = {
      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDDLq9FuqWxhgoUARBIkHIDR31zay4kSo59m/p2gjX3yFSEuonW9Dh9FkYThBRBJvoadXmAB7TYLP+6Ma6R2BLR6wr7Q05L79OFBmJLztgE6KD/BHdCwJJE/gxvVJzk7OiLT7xKnQHASSkfvgZt/krvnByNREbd30KKJsWD191JdSZhWclkMA34/kCqd2BhItxLeb3BNq6cgfJdxx+fYg9p/0PkW14xYaRughNHv+v5wh4s/dWTNhh06quwiu5oaS74MP2osJJAU0yN3ddXqBguW8fklMN5WRxy7m3pnsUCDAT6MDH/+fhdTCk75tkYdlVfV6yaKrkP5dnHZpyuHiyolaDGPTKbnLW9gnE/OVgBJelGsEeP+GDkbd16v8rDyiTYDKEgpdP5pRNBd+PBmltYHMfP/Ck3sOdzE9ZB4rwExew3dWl4n/gGzveo8ZuTcf3nXRSZddAiBuxz3wENzsQEPLtyfCmv+ONc6nrCD57RRzvF05a5scGUe4QqeAzaWmp7FbdXaieudvTQL2xiXMSUwaPx+PXOFnhk7Dr0jpBmirfKMinK+mQKzuxomnKCPKtQublMhmx4922P1xoI9R3FohY2HEbpCROrPcBnWEuHVxrlwOCLAq1/ZtUWuzAIcvtBqGSdbBYl6A+OEvKstQD46WrgrC3BJGLtcfRK1NITJw== ltp@nixos"
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCp33NKY9pJxYu1wgV/vemJwAHiWsSfmf3n39y1PU/yQmOHbTmBmogJ0xIp0YbVtdHI3G7qg5XkIUffTOAOVHaifrSeknFK9xzhFFI0idGKcbS1djdXiYhCQjDI3OxXx8G47LP1UpVmF1QWcQRWUvVESUtMAnQ3IwlSNhovAOa/YFRcKCi1C24gPeEzJQCnb4daw+YcrMfv3vieBrhlIZaOOoYDqx8zvUNh+hp5Ys4YvPy+wVEYAl3bzA+NJO60mFv1SzoIUZZkBLTUjpR+VCkI9jljEGe7VZchOW/8RXDaGmE9DRBaOqms6VTms2ePmlqDIGCgeYw1nWxsc9XV+tH3TVrfaQ//ACYE3PzRo0uwFW2dI5Ph6scffKoQ2BbAhZbs/KYvlQt+ru6P8P1bKiUMxUAzX5jzgo9ammue8BtTsRJ2Vb1v/I2d155njfKv/oNwS++47FJ9gKpvZuyRtrDzSCYPxWuclLliR3b4+5nyMKkVMMfpjn5mCV1bVGHKvY0= u0_a129@localhost"
      ];
      isNormalUser = true;
      shell = pkgs.zsh;
      extraGroups = [
        "wheel"
        "networkmanager"
        "docker"
        "pi"
      ];
    };
    groups."pi".gid = 1000;
  };

  security.sudo.wheelNeedsPassword = false;

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
  ];

  environment.systemPackages = with pkgs; [
    vim

    tree
    tmux
    git
    python3

    bat
    ripgrep

    dig
    traceroute

    parted
    cryptsetup

    ranger

    zig
    gcc

    libraspberrypi
    raspberrypi-eeprom
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
