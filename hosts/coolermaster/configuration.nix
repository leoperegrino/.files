{lib, config, pkgs, ... }:
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

  boot = {
    loader = {
      # timeout = 0;
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

  # https://nixos.wiki/wiki/Nvidia#Modifying_NixOS_Configuration
  hardware = {
    opengl.enable = true;
    # graphics.enable = true;
    # graphics.enable32Bit = true;
    # https://github.com/NixOS/nixpkgs/issues/322400#issuecomment-2282891939
    nvidia-container-toolkit.enable = true;
    nvidia = {
      # Modesetting is required.
      modesetting.enable = true;
      powerManagement = {
        enable = false;
        finegrained = false;
      };
      open = false;
      nvidiaSettings = true;
      nvidiaPersistenced = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };

  documentation.nixos.enable = false;

  console.useXkbConfig = true;

  networking = {
    networkmanager.enable = true;
    hostName = "coolermaster";
    firewall = {
      enable = true;
      allowedTCPPorts = [
        80
        443
        50000
        50001
        51413
        22000
      ];
      allowedUDPPorts = [
        51413
        22000
        21027
        51820
      ];
      checkReversePath = true;
      logRefusedConnections = false;
      logRefusedPackets = false; # this generates a lot of log
      logRefusedUnicastsOnly = false;
      logReversePathDrops = false;
    };
  };

  services = {
    xserver = {
      enable = false;
      videoDrivers = [ "nvidia" ];
    };
    openssh = {
      enable = true;
      authorizedKeysInHomedir = false;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };
  };

  users = {
    users."cool" = {
      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCzXCQtXnv7icwj2pYbYiifx0EtuOzX8L5PPVFKsFyIg40m3et2eJmNXdzgrhIiPt4ZHQ7VmC22ZxHzOuYNHT/bPR5DrL/DDuAblJgGdc/alkx3MaSuYDcIBi133mQpIHPNUJU2B97tWqXQsvpvIalsWR5UpGLyGfUU03zIemwBbZ4OtCAUn5FMpoSi5v4wsWxJ8vgiiT4/lj7adK1YivKTN+2B1eOxjiUukD0sEifxhlWXZ6p9mQd3d3JY0tLvONhwmxAWQ2L9LbIFOkNnYt5eDeOho5k+Bid8TT0cfc1MBV+qumfYe6KnFSH0TJc7kjnSS2N0s4Ue3h3UeY+b16g2bsipoRH0YP0NGEqr4+oNfIF0sJ0RVOo6qQs6kxx04aweEfatNgBnYpM8ItHPVX7yw787wPatWCJoKqr3GvN9rjSRoS7YeR/elr42Cs6c/zzqcnjLjs9etdLGyH38fSI/pZKLwqoVDH/gal/GShQz7jzJGygVEL+rs0EsFCVUpwDlIIuE/HdE/Nyon6Ufl3q9IvSf0fbmwgtL6q7dYGA8bUXSVxl2uDj35b6Yh2N9huRPOX8WciOvpDXvvc6GqkcuZmoSPETDqlPgvpfFQSMEfIBlUtFePVX207g1yP067RIbJnYIy+CITemlvjWwU1kzsucFxkx3QVdcyJmpL42MAw== ltp@nixos"
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCp33NKY9pJxYu1wgV/vemJwAHiWsSfmf3n39y1PU/yQmOHbTmBmogJ0xIp0YbVtdHI3G7qg5XkIUffTOAOVHaifrSeknFK9xzhFFI0idGKcbS1djdXiYhCQjDI3OxXx8G47LP1UpVmF1QWcQRWUvVESUtMAnQ3IwlSNhovAOa/YFRcKCi1C24gPeEzJQCnb4daw+YcrMfv3vieBrhlIZaOOoYDqx8zvUNh+hp5Ys4YvPy+wVEYAl3bzA+NJO60mFv1SzoIUZZkBLTUjpR+VCkI9jljEGe7VZchOW/8RXDaGmE9DRBaOqms6VTms2ePmlqDIGCgeYw1nWxsc9XV+tH3TVrfaQ//ACYE3PzRo0uwFW2dI5Ph6scffKoQ2BbAhZbs/KYvlQt+ru6P8P1bKiUMxUAzX5jzgo9ammue8BtTsRJ2Vb1v/I2d155njfKv/oNwS++47FJ9gKpvZuyRtrDzSCYPxWuclLliR3b4+5nyMKkVMMfpjn5mCV1bVGHKvY0= u0_a129@localhost"
      ];
      isNormalUser = true;
      shell = pkgs.zsh;
      extraGroups = [
        "wheel"
        "networkmanager"
        "cool"
        "video"
      ]
      ++ (if virtCfg.docker.enable then [ "docker" ] else [])
      ;
    };
    groups."cool".gid = 1000;
  };

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "nvidia-x11"
      "nvidia-settings"
      "nvidia-persistenced"
      "cuda-merged"
      "cuda_cuobjdump"
      "cuda_gdb"
      "cuda_nvcc"
      "cuda_nvdisasm"
      "cuda_nvprune"
      "cuda_cccl"
      "cuda_cudart"
      "cuda_cupti"
      "cuda_cuxxfilt"
      "cuda_nvml_dev"
      "cuda_nvrtc"
      "cuda_nvtx"
      "cuda_profiler_api"
      "cuda_sanitizer_api"
      "libcublas"
      "libcurand"
      "libcufft"
      "libcusolver"
      "libnvjitlink"
      "libnpp"
      "libcusparse"
    ];

  environment.systemPackages = with pkgs; [
    nvtopPackages.nvidia
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
