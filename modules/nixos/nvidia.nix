{ pkgs, lib, config, ... }:

{
  
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    nvidiaSettings = false;
    powerManagement.enable = true;
    powerManagement.finegrained = true;
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };

      intelBusId = "PCI:0:2:0";
    
      nvidiaBusId = "PCI:1:0:0";
      };
    };

  specialisation = {
    nvidia.configuration = {

      hardware.nvidia = {
        prime.sync.enable = lib.mkForce true;
        powerManagement.enable = lib.mkForce false;
        powerManagement.finegrained = lib.mkForce false;
        prime.offload = {
          enable = lib.mkForce false;
          enableOffloadCmd = lib.mkForce false;
        };
      };

    };
  };

}
