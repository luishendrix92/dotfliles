return  {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local nvimtree = require("nvim-tree")

    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    nvimtree.setup({
      diagnostics = {
        enable = true,
      },
      view = {
        side = "right",
      },
      renderer = {
        indent_markers = {
          enable = true,
        },
        group_empty = true,
        icons = {
          web_devicons = {
            folder = { enable = true },
          },
        },
      },
    })

    local keymap = vim.keymap

    keymap.set("n", "<C-n>", "<cmd>NvimTreeToggle<CR>")
  end,
}
