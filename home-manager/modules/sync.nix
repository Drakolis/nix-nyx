{ pkgs, ... }:
{
  home.packages = with pkgs; [
    vdirsyncer
    rclone
    syncthingtray-qt6
  ];

  services.syncthing = {
    enable = true;
    # tray.enable = true;
    settings = {
      gui = {
        user = "drakolis";
      };
      devices = {
        "YDdraigGoch" = {
          id = "";
        };
      };
      folders = {
        "Drakolis Files" = {
          path = "/home/drakolis/Shared";
          devices = [
            "YDdraigGoch"
          ];
        };
      };
    };
  };
}
