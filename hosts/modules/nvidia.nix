{lib, config, pkgs, ...}:
let
  cfg = config.modules.hosts.nvidia;
in {

  options.modules.hosts = {
    nvidia.enable = lib.mkEnableOption "nvidia support";
  };

  config = lib.mkIf cfg.enable {

    # https://nixos.wiki/wiki/Nvidia#Modifying_NixOS_Configuration
    hardware = {
      graphics.enable = true;
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

    services = {
      xserver = {
        videoDrivers = [ "nvidia" ];
      };
    };

    environment.systemPackages = with pkgs; [
      nvtopPackages.nvidia
    ];

    modules.hosts.nix = {
      enable = true;

      unfreePkgs = [
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
    };

  };

}
