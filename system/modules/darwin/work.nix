{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    asdf-vm
    awscli
    kubectl
    # aws-azure-login
    colima
    docker
    docker-buildx
    docker-compose
  ];
}
