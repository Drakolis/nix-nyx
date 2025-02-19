{ pkgs, ... }: {
  environment.systemPackages = with pkgs;
    [
      # Keyboard configuration
      vial
    ];

  # Vial/Via support
  services.udev.packages = with pkgs; [ vial via ];
}
