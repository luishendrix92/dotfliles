return {
  "L3MON4D3/LuaSnip",
  build = "make install_jsregexp",
  lazy = true,
  config = function()
    local ls = require('luasnip')
    local types = require("luasnip.util.types")

    require("luasnip.loaders.from_lua").lazy_load({
      paths = "~/.config/nvim/snippets/"
    })

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
  end
}
