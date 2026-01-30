{
  config,
  pkgs,
  ...
}:
let
  virtCfg = config.modules.hosts.virtualisation;
in
{

  imports = [
    ../modules/default.nix
  ];

  modules.hosts = {
    locale.enable = true;
    nix.enable = true;
    xserver.enable = true;
    virtualisation.docker.enable = true;
    virtualisation.virtualbox.enable = false;
    virtualisation.virt-manager.enable = true;
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    # consoleLogLevel = 0;
    # kernelParams = ["quiet"];
    binfmt.emulatedSystems = [ "aarch64-linux" ];
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

  hardware = {
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
    networkmanager = {
      enable = true;
      plugins = [
        pkgs.networkmanager-openconnect
      ];
    };
    firewall.enable = true;
    hostName = "thinkpad";
  };

  services = {
    hardware.bolt.enable = true;
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
    ]
    ++ (if virtCfg.virt-manager.enable then [ "libvirtd" ] else [ ])
    ++ (if virtCfg.virtualbox.enable then [ "vboxusers" ] else [ ])
    ++ (if virtCfg.docker.enable then [ "docker" ] else [ ]);
  };

  programs.zsh.enable = true;
  programs.zsh.enableGlobalCompInit = false;
  # https://github.com/nix-community/home-manager/blob/366d78c2856de6ab3411c15c1cb4fb4c2bf5c826/modules/programs/bash.nix#L53-L66
  # https://github.com/nix-community/home-manager/blob/75ed713570ca17427119e7e204ab3590cc3bf2a5/modules/programs/zsh/default.nix#L161-L167
  environment.pathsToLink = [
    "/share/bash"
    "/share/zsh"
  ];

  security.sudo.wheelNeedsPassword = false;

  modules.hosts.nix.unfreePkgs = (
    if virtCfg.virtualbox.enable then [ "Oracle_VirtualBox_Extension_Pack" ] else [ ]
  );

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
