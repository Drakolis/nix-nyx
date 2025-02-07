This directory holds config files which you shouldn't link (eg. tool is configurable from UI) and yet I want to have these under VCS as well. Examples are VSCode(ium), KeePassXC, Thunar, etc... Instead of using Nix these work using the following scripts:
* init - copies the selected config files *TO* the machine, but only if they do not exist
* deploy - copies the selected config files *TO* the machine, overwriting them if they exist
* collect - copies the selected config files *FROM* the machine
