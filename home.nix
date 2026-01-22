{ config, pkgs, inputs, ... }:
{
  home.username = "nixfel";
  home.homeDirectory = "/home/nixfel";
  home.stateVersion = "25.11";
  programs.home-manager.enable = true;

  imports = [
    ./spicetify.nix
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ll = "ls -l";
      nrs = "sudo nixos-rebuild switch";
      ncg = "sudo nix-collect-garbage";
      grep = "grep --color=auto";
      btw = "echo 'I use NixOS btw'";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" "z" ];
    };
    plugins = [
      {
        name = "powerlevel10k";
	src = pkgs.zsh-powerlevel10k;
	file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];
    initContent = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      test -f ~/.p10k.zsh && source ~/.p10k.zsh

      fastfetch
    '';
  };
}
