{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # ASDF
    asdf-vm

    # CLIs
    awscli
    kubectl
    # aws-azure-login

    # Docker related
    colima
    docker
    docker-buildx
    docker-compose
  ];
}
