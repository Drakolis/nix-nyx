self: super: {
  openrgb = super.openrgb.overrideAttrs (oldAttrs: {
    version = "1.0-rc2"; # Example experimental version
    src = super.fetchFromGitLab {
      owner = "CalcProgrammer1";
      repo = "OpenRGB";
      rev = "refs/tags/1.0-rc2";
      sha256 = "sha256-value-for-archive";
    };
    # Add buildInputs or patches as needed
  });
}
