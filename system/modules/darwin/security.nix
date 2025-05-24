{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    termshark
    keepassxc
    nmap
    lynis # Security audit
  ];
}
