local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

require('telescope').setup {
  defaults = {
    file_ignore_patterns = { "plugged" }
  },
  pickers = {
    find_files = {
      theme = 'dropdown',
      previewer = false
    }
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
    }
  }
}

keymap('n', '<leader>th', '<cmd>Telescope help_tags<CR>', opts)
keymap('n', '<leader>tf', '<cmd>Telescope find_files<CR>', opts)
keymap('n', '<leader>tg', '<cmd>Telescope live_grep<CR>', opts)
keymap('n', '<leader>tr', '<cmd>Telescope registers<CR>', opts)
keymap('n', '<leader>ts', '<cmd>Telescope luasnip<CR>', opts)
keymap('n', '<leader>tb', '<cmd>Telescope buffers<CR>', opts)
keymap('n', '<leader>tt', '<cmd>TodoTelescope<CR>', opts)

require('telescope').load_extension('fzf')
require('telescope').load_extension('luasnip')
