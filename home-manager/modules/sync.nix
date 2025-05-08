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
          id = "NHJSCOU-DUNYOC3-ZSMG4ZF-IKWJZOF-Y2DKF2V-2MOWFU4-EXZJRG7-PP235AO";
        };
        "WinterDragon" = {
          id = "J3ABNVA-VXV3CBZ-FWYWKWY-UXZNNKW-SSNSCLZ-KTU35OS-PE6YUHR-EIEOCA5";
        };
      };
      folders = {
        "Drakolis Files" = {
          path = "/home/drakolis/Shared";
          devices = [
            "YDdraigGoch"
            "WinterDragon"
          ];
        };
      };
    };
  };
}
