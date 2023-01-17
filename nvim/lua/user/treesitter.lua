local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
local configs = require('nvim-treesitter.configs')

configs.setup {
  ensure_installed = {
    'html',
    'clojure',
    'css',
    'elixir',
    'haskell',
    'typescript',
    'javascript',
    'tsx',
    'java',
    'c',
    'cpp',
    'c_sharp',
    'json',
    'lua',
    'elm',
    'markdown',
    'python',
    'latex'
  },
  sync_install = false,
  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = { enable = true },
  context_commentstring = {
    enable = true,
    enable_autocmd = false
  }
}

-- Third-party parser installation
parser_config.jsp = {
  install_info = {
    url = "https://github.com/merico-dev/tree-sitter-jsp",
    files = {"src/parser.c"},
    branch = "master",
    generate_requires_npm = false,
    requires_generate_from_grammar = false,
  },
  filetype = "jsp",
}
