{ pkgs, ... }:
{
  home.packages = with pkgs; [
    vdirsyncer
    rclone
  ];

  services.syncthing = {
    enable = true;
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
