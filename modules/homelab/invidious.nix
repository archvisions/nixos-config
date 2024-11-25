{ pkgs, lib, config, ... }:

{
  services.invidious = {
    enable = true;
    address = "127.0.0.1";
    settings = {
      default_user_preferences = {
        locale = "en_US";
        region = "US";
        captions = [ "English" "English (auto-generated)" ];
        feed_menu = [ "Trending" ];
        player_style = "youtube";
        quality = "dash";
        dark_mode = "dark";
      };
      port = lib.mkDefault 3000;
      signature_server = lib.mkDefault "127.0.0.1:2999";
      login_enabled = false;
      po_token = "Mnhv3F7b8GDtDm_gY4adeKxI-sxBsmRWa266q7IibYK7Eziw6Z7Z3VCVRWfIaj3PM4ZhQw4jt5KR2erA5sRKt1MZCuoIGb_nuIClkERxG9CPOEBLs9dimwh2KY33qPlnrGL8HsHgP7s40OtgegM9lPHgPryAGd0j5WM=";
      visitor_data = "CgtYQmNIY2VwLVNWSSiov5K6BjIKCgJVUxIEGgAgRQ%3D%3D";
      https = true;
    };
    database = {
      createLocally = true;
    };
    sig-helper = {
      enable = true;
    };
  };    
}
