{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ tailscale ];

  services.tailscale.enable = true;
  services.tailscale.authKeyFile = "/run/secrets/tailscale_key";
}
