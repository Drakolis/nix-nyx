{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Language Statistics
    tokei

    # Python
    python3

    # NodeJS
    nodejs
    typescript-language-server
    vue-language-server
    dockerfile-language-server-nodejs

    # CLI
    scaleway-cli

    # Other languages
    yaml-language-server
    docker-compose-language-service
    terraform-ls
    lua-language-server
    java-language-server
    rust-analyzer
  ];
}
