{ config, pkgs, ... }:
{
    programs.home-manager.enable = true;
    home.username = "gordo";
    home.homeDirectory = "/Users/gordo";
    home.stateVersion = "24.05";

    xdg = {
        configFile.nvim.source = ../nvim;
        configFile.wezterm.source = ../wezterm;
    };

    programs.git = {
        enable = true;
    };

    programs.wezterm = {
        enable = true;
    };

    programs.fish = {
        enable = true;
        # interactiveShellInit = ''
        #   fastfetch
        # '';
    };

    programs.fastfetch = {
      enable = true;
    };

    programs.tmux = {
      enable = true;

      prefix = "C-Space";
      baseIndex = 1;
      keyMode = "vi";
      escapeTime = 0;
      mouse = true;
      terminal = "screen-256color";

      extraConfig = ''
        set -g status-right ""
        set -g status-style bg=default
      '';
    };

    programs.neovim = {
            enable = true;

            withRuby = true;
            withNodeJs = true;
            withPython3 = true;

            extraPackages = with pkgs; [
              git
              gcc
              gnumake
              unzip
              wget
              curl
              tree-sitter
              ripgrep
              fd
              fzf
              cargo

              lua-language-server
              stylua
              nil
              alejandra

              gopls
            ];
    };

    programs.lf = {
      enable = true;
    };
}
