# Dotfiles

## Dependencies

### System
*name (reason)* <br>

- git
- make (nvim plugin)
- stow (to 'install' the dotfiles)
- nvim
- tmux
- fzf (used by tmux keybindings and nvim telescope)
- ripgrep (used by nvim telescope)
- g++ (treesitter want's to compile some stuff)
- starship (shell PS1)

Optional:
- npm (allows some more language servers for nvim but .... it's a heavy dependency)
- delve (go debugging)
- gdb (c/zig debugging)
- debugpy (python debugging)

## Install

```bash
# install system requirements see dependencies

# get the tmux plugin manager
if ! [[ -d "$HOME/.tmux/plugins/tpm" ]]; then
    git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
    $HOME/.tmux/plugins/tpm/bin/install_plugins
fi

# 'install' dot files
stow --target "$HOME" --dir '/path/to/cloned/repo' .

# install python dependencies
pip3 install debugpy

# install nvm -> node to enalble lsp for bash and python
# see [link](https://github.com/nvm-sh/nvm?tab=readme-ov-file#install--update-script)
```

