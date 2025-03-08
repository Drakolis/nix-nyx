{ config, lib, pkgs, ... }: {
  home.packages = with pkgs; [ vdirsyncer rclone ];
}
