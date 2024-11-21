{ pkgs, ... }:

{
  # Enable Xorg server
  services.displayManager.ly.enable = true;

  services.xserver = {
    enable = true;
    windowManager.dwm.enable = true;
    libinput.enable = true;
    dpi = 81;
  };

  # Enable DWM
  services.xserver.windowManager.dwm.package = pkgs.dwm.overrideAttrs {
    src = fetchGit {
      url = "https://github.com/archvisions/archvisions-dwm.git";
      ref = "master";
      rev = "e3597cf426e9b7da556fd9ea1cad3844b00130a4";
    };
    nativeBuildInputs = with pkgs; [
      xorg.libX11
      xorg.libXft
      imlib2
      xorg.libXinerama
    ];
  };
}
