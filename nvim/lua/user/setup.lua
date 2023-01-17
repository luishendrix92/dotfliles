-- Colorscheme related
vim.g['tokyonight_lualine_bold'] = true
vim.cmd('colorscheme tokyonight')
vim.g['gruvbox_contrast_dark'] = 'hard'

-- Lualine
----------
require('lualine').setup {
  options = {
    theme                = 'auto',
    section_separators   = { left = '', right = '' },
    component_separators = { left = '|', right = '|' }
  }
}

-- Tabline
----------
require('tabline').setup {
  options = {
    modified_italic = false,
    section_separators = { '', '' },
    component_separators = { '', '' }
  }
}

-- Neovim Tree
--------------
require 'nvim-tree'.setup {
  diagnostics = {
    enable = true
  },
  git = {
    ignore = false
  }
}

vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- TODO Comments
----------------
require("todo-comments").setup {}

-- Lsp Progress Virtual Text
require "fidget".setup {}

-- Git signs
require('gitsigns').setup {}

-- Luasnip configuration
-- ---------------------
local ls = require('luasnip')
local types = require("luasnip.util.types")

require('luasnip.loaders.from_vscode').lazy_load()
require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/snippets/" })

ls.config.set_config({
  store_selection_keys = '<C-s>',
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "●", "DiagnosticHint" } }
      }
    },
    [types.insertNode] = {
      active = {
        virt_text = { { "●", "Comment" } }
      }
    }
  },
})

vim.keymap.set({ 'i', 's' }, '<A-j>', function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

vim.keymap.set({ 'i', 's' }, '<A-k>', function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })

vim.keymap.set({ 'i', 's' }, '<A-l>', function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)

vim.keymap.set({ 'i', 's' }, '<A-h>', function()
  if ls.choice_active() then
    ls.change_choice(-1)
  end
end)

-- Plugin to comment out lines
require('Comment').setup {
  pre_hook = function(ctx)
    local U = require 'Comment.utils'
    local location = nil

    if ctx.ctype == U.ctype.block then
      location = require('ts_context_commentstring.utils').get_cursor_location()
    elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
      location = require('ts_context_commentstring.utils').get_visual_start_location()
    end

    return require('ts_context_commentstring.internal').calculate_commentstring {
      key = ctx.ctype == U.ctype.line and '__default' or '__multiline',
      location = location
    }
  end
}
