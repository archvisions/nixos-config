{ pkgs, ... }:

{
  # Enable Xorg server
  services.xserver = {
    enable = true;
    windowManager.dwm.enable = true;
    displayManager.startx.enable = true;
    libinput.enable = true;
    dpi = 81;
  };

  # Enable DWM
  services.xserver.windowManager.dwm.package = pkgs.dwm.overrideAttrs {
    src = fetchGit {
      url = "https://github.com/archvisions/archvisions-dwm.git";
      ref = "master";
      rev = "6d482dec02b5f71177bf5b646359849650ff9cfd";
    };
    nativeBuildInputs = with pkgs; [
      xorg.libX11
      xorg.libXft
      imlib2
      xorg.libXinerama
    ];
  };
}
