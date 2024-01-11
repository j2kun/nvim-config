# Setting up Neovim on a new machine

Ensure python3.10 is installed, this also may require installing pip/ensurepip
for python3.10, something like `sudo apt install python3.10-venv` on
Debian/Ubuntu.

## Install instructions

This is an incomplete list. Add more as I find things break when I install on a
new machine.

### nvim-specific virtualenv

```
python3.10 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

This allows nvim to have its own version of python-lsp-server, etc., separate
from the virtualenv that is used for a specific python project. Note that
without this, you'll see an error when neovim starts up that it can't find the
python interpreter or pylsp, because of this line in `init.vim`:

```
let g:python3_host_prog=$HOME."/.config/nvim/venv/bin/python3"
```

### Treesitter

```
cargo install tree-sitter-cli
```

Then open neovim and run `:PlugInstall` and `:TSInstall all`

### Language servers

`lua/language_server.lua` contains configs for language servers. The python
server is handled by the virtualenv install above, but others require manual
installation, adding to the system `$PATH`.

The [lua_ls](https://github.com/sumneko/lua-language-server) is particularly
strange and custom. Clone/build it at `~/.local/lua-language-server` and the
config will find the binary.

The [yaml-language-server](https://www.npmjs.com/package/yaml-language-server)
is installed via `sudo npm install -g yaml-language-server`.

The golang language server [gopls](https://github.com/golang/tools/tree/master/gopls)
is installed via `go install golang.org/x/tools/gopls@latest`. This may require
`$PATH` to include a custom go binary dir configuration (e.g.,
`/usr/local/go/bin` or `$HOME/go/bin`).

### Nerd fonts

Optionally install [nerd fonts](https://www.nerdfonts.com/) for your system for
the `symbols-outline` plugin (it won't break but the icons in the outline
window will look odd).
