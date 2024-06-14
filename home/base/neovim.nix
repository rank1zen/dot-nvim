{
  pkgs,
  ...
}: {

  xdg = {
    configFile.nvim.source = ../nvim;
  };

  programs.neovim = {
    enable = true;

    defaultEditor = true;

    withRuby = true;
    withNodeJs = true;
    withPython3 = true;

    extraPackages = with pkgs; [
      tree-sitter
      cmake
      gnumake

      git
      gcc

      unzip
      wget
      curl
      ripgrep
      fd
      cargo
      lua-language-server
      stylua

      nil
      alejandra

      gopls
    ];
  };
}
