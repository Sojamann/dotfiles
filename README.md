# Dotfiles

## Dependencies

- git
- make (nvim plugin)
- stow
- nvim
- tmux
- fzf (used by tmux keybindings and nvim telescope)
- ripgrep (used by nvim telescope)
- g++ (treesitter want's to compile some stuff)
- starship

Optional:
- npm (allows some more language servers for nvim but .... it's a heavy dependency)
- delve (go debugging)
- gdb (c/zig debugging)
- debugpy (python debugging)

## Install

```bash
# get the tmux plugin manager
if ! [[ -d "$HOME/.tmux/plugins/tpm" ]]; then
    git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
    $HOME/.tmux/plugins/tpm/bin/install_plugins
fi

stow --target "$HOME" --dir '/path/to/cloed/repo' .
```

