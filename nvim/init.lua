require('user.options') -- Vim/neovim options, and global variables
require('user.plugins') -- Plugin list (current engine: Vim-Plug)
require('user.mappings') -- Custom keymaps for native and plugin actions
require('user.setup') -- Plugin specific configuration
require('user.scope') -- Telescope settings, name is to prevent module conflict
require('user.lsp') -- Built-in LSP settings and extensions_config
require('user.completion') -- Autocompletion (current engine: nvim-cmp)
require('user.treesitter') -- Treesitter settings and extensions
