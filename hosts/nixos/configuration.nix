{lib, pkgs, host, user, ...}:
{

  imports = [
    ../modules/default.nix
    ../modules/virtualisation.nix
  ];

  modules.hosts.enable = true;
  modules.hosts.virtualisation.podman.enable = true;
  modules.hosts.virtualisation.virtualbox.enable = true;
  modules.hosts.syncthing.enable = true;

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    consoleLogLevel = 0;
    kernelParams = ["quiet"];
    binfmt.emulatedSystems = [ "aarch64-linux" ];
    loader = {
      timeout = 0;
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        configurationLimit = 10;
        enableCryptodisk = true;
        timeoutStyle = "hidden";
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
    hostName = host;
  };

  services = {
    printing.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };

  users.users."${user}" = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "audio"
      "wheel"
      "networkmanager"
    ];
  };

  security.sudo.wheelNeedsPassword = false;

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
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
