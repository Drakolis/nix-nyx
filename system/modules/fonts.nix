{
  pkgs,
  lib,
  ...
}:
{
  fonts.packages =
    with pkgs;
    [
      ubuntu-sans
      ubuntu-sans-mono
      nerd-fonts.ubuntu
      nerd-fonts.ubuntu-mono

      noto-fonts
      noto-fonts-extra
      noto-fonts-cjk-sans

      hack-font
      nerd-fonts.hack

      jetbrains-mono
      nerd-fonts.jetbrains-mono
    ]
    ++ lib.optionals stdenv.hostPlatform.isLinux [
      noto-fonts-emoji
    ];
}
