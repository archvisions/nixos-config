{ pkgs, lib, ... }:

{
  users.groups.nas = {};
  users.users.jellyfin.extraGroups = [ "nas" ];

  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      vaapiVdpau
      libvdpau-va-gl
      intel-compute-runtime 
      vpl-gpu-rt
      intel-media-sdk
    ];
  };

  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };
}
