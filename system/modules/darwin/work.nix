{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # ASDF
    asdf-vm

    # Docker related
    colima
    docker
    docker-buildx
    docker-compose
  ];
}
