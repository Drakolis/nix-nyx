{ pkgs, lib, ... }:
with lib;
{
  home.packages = with pkgs; [
    vdirsyncer
    rclone
  ];

  services.syncthing = {
    enable = true;
    tray = {
      enable = true;
      package = pkgs.syncthingtray;
    };
    settings = {
      devices = {
        "YDdraigGoch" = {
          id = "NHJSCOU-DUNYOC3-ZSMG4ZF-IKWJZOF-Y2DKF2V-2MOWFU4-EXZJRG7-PP235AO";
        };
        "WinterDragon" = {
          id = "J3ABNVA-VXV3CBZ-FWYWKWY-UXZNNKW-SSNSCLZ-KTU35OS-PE6YUHR-EIEOCA5";
        };
        "SilverWing" = {
          id = "LBYLECX-MQK2OZ3-ZHGJCEX-AGG3PIN-ISLJRYM-P2U6ICX-5LTDMAT-UEWBJQY";
        };
        "mb-H02L4YFQ6P" = {
          id = "ZZKPN74-4BCOU4T-6K4IXL3-IKL4DDF-7B3JIDX-2LWZWGU-OPYYJJS-SEDALAZ";
        };
        "Joermungandr" = {
          id = "FLWAKCR-RDRCUZD-4JLCEX4-T2FJVNI-VVFAW33-3NEYJKT-S3DKMU7-NSI44A3";
        };
        "Quetzalcoatl" = {
          id = "4W7HQHM-RSS6JIO-DZS4S55-PPHKK4A-55XFM5F-TFUH2AK-4JMKX3G-YZ7GDAJ";
        };
      };
      folders = {
        "Drakolis Files" = {
          path = "~/Shared";
          devices = [
            "YDdraigGoch"
            "WinterDragon"
            "SilverWing"
            "mb-H02L4YFQ6P"
            "Joermungandr"
            "Quetzalcoatl"
          ];
        };
      };
    };
  };
}
