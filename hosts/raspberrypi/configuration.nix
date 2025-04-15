{lib, config, pkgs, ...}:
let
  virtCfg = config.modules.hosts.virtualisation;
in {

  imports = [
    ../modules/default.nix
  ];

  modules.hosts = {
    environment.enable = true;
    locale.enable = true;
    nix.enable = true;
    programs.enable = true;
    virtualisation.docker.enable = true;
  };

  hardware = {
    enableRedistributableFirmware = true;
    raspberry-pi."4".apply-overlays-dtmerge.enable = true;
    deviceTree = {
      enable = true;
      filter = "*rpi-4-*.dtb";
    };
  };
  nix.settings.trusted-users = [ "pi" ];
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
    authorizedKeysInHomedir = false;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  users = {
    users."pi" = {
      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDPKWxkrgaYoifPqAa+WcHAwExQqSCrVjqB2Lthb3+l3mMaCKppWYF3EmLjM9I1qqorlDOeAlYwnDsAVbch4P982ktjQZlMjJcA7oJ2VzzJujndaBUrajBtfAYcGQ2maadu4tP5w7wHHjgyNDI2fet9Fs6YEWIqKsFGCca0OIwjG4Jvq7LkLryY/cRCaL71bL8lpZSvx+X1sYOTBWiY7FtzyjS8FRPEwk0NvTCu2IxvFQAw7clDRX9uVN/lxU08UsRR9XutAXOiZxU8Qh0Xq2mB2iW52oO0Ce70olDZ/iFe5NnbRYjyuDSe3EuLQV/mPmb7uFBuHUQEPjUJf0IddewSGWahAW1ly5N4jRYinW36qzTOxF6AacK6f8g7RvV+PrB8IPJikwvQNnmBHurIWg1CpVvpZdnojQ2K//KlEcFbV00Ixt1hYsPryYRaLyoYUknYC49b2Oh6GlMnkPhMMTPT+DynvqpdC2SZm2N5dAT1NwSb9pFWanKfZ2qkq+0HlK4678Jd2eXSUITS9w52rW1d/3CV6WNICTjAIqkaM3kSZNE7eWjnsBQ3CAZwAWpHuRGC0c9XZGlLGRYM286q8p4TiPUxGqzExAzRZ71itA/1l0l9ihTdvohV9Rcy1Uy1jgDkySzcxdLLFbiyemCmI5IxVFd11K7pVXRBTtVeYvKYaQ== ltp@thinkpad"
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCp33NKY9pJxYu1wgV/vemJwAHiWsSfmf3n39y1PU/yQmOHbTmBmogJ0xIp0YbVtdHI3G7qg5XkIUffTOAOVHaifrSeknFK9xzhFFI0idGKcbS1djdXiYhCQjDI3OxXx8G47LP1UpVmF1QWcQRWUvVESUtMAnQ3IwlSNhovAOa/YFRcKCi1C24gPeEzJQCnb4daw+YcrMfv3vieBrhlIZaOOoYDqx8zvUNh+hp5Ys4YvPy+wVEYAl3bzA+NJO60mFv1SzoIUZZkBLTUjpR+VCkI9jljEGe7VZchOW/8RXDaGmE9DRBaOqms6VTms2ePmlqDIGCgeYw1nWxsc9XV+tH3TVrfaQ//ACYE3PzRo0uwFW2dI5Ph6scffKoQ2BbAhZbs/KYvlQt+ru6P8P1bKiUMxUAzX5jzgo9ammue8BtTsRJ2Vb1v/I2d155njfKv/oNwS++47FJ9gKpvZuyRtrDzSCYPxWuclLliR3b4+5nyMKkVMMfpjn5mCV1bVGHKvY0= u0_a129@localhost"
      ];
      isNormalUser = true;
      shell = pkgs.zsh;
      extraGroups = [
        "wheel"
        "networkmanager"
        "pi"
      ]
    ++ (if virtCfg.virt-manager.enable then [ "libvirtd" ] else [])
    ++ (if virtCfg.virtualbox.enable then [ "vboxusers" ] else [])
    ++ (if virtCfg.docker.enable then [ "docker" ] else [])
      ;
    };
    groups."pi".gid = 1000;
  };

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
  ];

  environment.systemPackages = with pkgs; [
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
