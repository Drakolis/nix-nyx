{ pkgs, ... }:
{
  environment.systemPackages =
    with pkgs;
    [ tailscale ]
    ++ lib.optionals stdenv.hostPlatform.isLinux [
      tailscale-systray
    ];

  services.tailscale.enable = true;
  services.tailscale.authKeyFile = "/run/secrets/tailscale_key";
}
