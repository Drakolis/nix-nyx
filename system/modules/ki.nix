{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ tabby-agent ];

  services.tabby = {
    enable = true;
    port = 50000;
    usageCollection = false;
  };
}
