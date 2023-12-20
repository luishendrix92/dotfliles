return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
  },
  config = function()
    local telescope = require("telescope")

    telescope.setup({
      defaults = {
        path_display = { "truncate " },
      },
      pickers = {
        find_files = {
          theme = "dropdown",
          previewer = false,
        },
        colorscheme = {
          enable_preview = true,
        },
      },
    })

    telescope.load_extension("fzf")

    local keymap = vim.keymap

    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
    keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>")
    keymap.set("n", "<leader>fr", "<cmd>Telescope registers<CR>")
    keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>")
    keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<CR>")
  end,
}
