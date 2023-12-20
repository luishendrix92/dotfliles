local M = {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  config = function()
    local treesitter = require("nvim-treesitter.configs")

    treesitter.setup({
      highlight = { enable = true, },
      indent = { enable = true },
      ensure_installed = {
        "markdown_inline",
        "markdown",
        "javascript",
        "typescript",
        "tsx",
        "json",
        "yaml",
        "html",
        "css",
        "bash",
        "lua",
        "vim",
        "gitignore",
        "python",
        "ocaml",
        "clojure",
        "elixir",
        "haskell",
      },
      incremental_selection = {
        enable = true,
      },
    })

    require('ts_context_commentstring').setup {}
  end,
}

return { M }
