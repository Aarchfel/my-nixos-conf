{ pkgs, spicetify-nix, inputs, ... }:

{
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

  programs.spicetify = 
  let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  in
  {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      adblock
      shuffle
      trashbin
      songStats
      beautifulLyrics
    ];
    theme = spicePkgs.themes.starryNight;
    colorScheme = "Base";
    enabledCustomApps = with spicePkgs.apps; [
      marketplace
    ];
  };
}
