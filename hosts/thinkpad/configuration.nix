{lib, config, pkgs, ...}:
{

  imports = [
    ../modules/default.nix
  ];

  modules.hosts = {
    environment.enable = true;
    locale.enable = true;
    nix.enable = true;
    programs.enable = true;
    xserver.enable = true;
    virtualisation.podman.enable = true;
    virtualisation.virtualbox.enable = true;
    virtualisation.virt-manager.enable = true;
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    # consoleLogLevel = 0;
    # kernelParams = ["quiet"];
    loader = {
      timeout = 3;
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        configurationLimit = 10;
        enableCryptodisk = true;
        # timeoutStyle = "hidden";
      };
    };
  };

  documentation.nixos.enable = false;

  console.useXkbConfig = true;

  hardware =  {
    bluetooth = {
      enable = true;
      settings = {
        General = {
          JustWorksRepairing = "always";
        };
      };
    };
  };

  networking = {
    networkmanager.enable = true;
    firewall.enable = true;
    hostName = "thinkpad";
  };

  services = {
    printing.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };

  users.users."ltp" = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "audio"
      "wheel"
      "networkmanager"
      (lib.mkIf config.modules.hosts.virtualisation.virtualbox.enable "vboxusers")
      (lib.mkIf config.modules.hosts.virtualisation.virt-manager.enable "libvirtd")
    ];
  };

  security.sudo.wheelNeedsPassword = false;

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    (lib.mkIf config.modules.hosts.virtualisation.virtualbox.enable "Oracle_VirtualBox_Extension_Pack")
  ];

  fonts.enableDefaultPackages = true;
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    (nerdfonts.override { fonts = [ "Noto" ]; })
  ];

  environment.systemPackages = with pkgs; [
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
