# Dotfiles

## Dependencies

- git
- stow
- nvim
- tmux
- fzf
- ripgrep
- starship

## Install

```bash
# get the tmux plugin manager
if ! [[ -d "$HOME/.tmux/plugins/tpm" ]]; then
    git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
    $HOME/.tmux/plugins/tpm/bin/install_plugins
fi

stow --target "$HOME" --dir '/path/to/cloed/repo' .
```

