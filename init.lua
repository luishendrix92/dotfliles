local Plug = vim.fn['plug#']
local keymap = vim.api.nvim_set_keymap
local o = vim.o   -- NeoVim Global
local wo = vim.wo -- Local to Window
--local bo = vim.bo -- Local to Buffer

-- Plugin Declarations
----------------------
vim.call('plug#begin', '~/.config/nvim/plugged')
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'nvim-lualine/lualine.nvim'
  Plug 'kyazdani42/nvim-tree.lua'
  Plug 'morhetz/gruvbox'

  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'onsails/lspkind-nvim'

  Plug 'L3MON4D3/LuaSnip'
  Plug 'saadparwaiz1/cmp_luasnip'
vim.call('plug#end')

o.autoindent = true
o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.softtabstop = 2
o.tabstop = 2
vim.o.hlsearch = true

wo.number = true
wo.wrap = true

keymap('n', '<F4>', ':nohlsearch<Bar> :echo<CR>', { noremap = true, silent = true })

require('lualine').setup()

require('lualine').setup {
  options = { theme  = 'gruvbox' },
}

-- Gruvbox Theme
vim.opt.background = "dark";
vim.cmd("colorscheme gruvbox");
vim.opt.termguicolors = true;

require'nvim-tree'.setup {
}

keymap('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- LSP and LSPSaga Settings
---------------------------
local on_attach = function(client, bufnr)
  -- Enable manual OmniFunc completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- TODO: LSPSaga Mappings
end

local capabilities = require('cmp_nvim_lsp')
  .update_capabilities(
    vim.lsp.protocol.make_client_capabilities()
  )

local nvim_lsp = require("lspconfig")

nvim_lsp.tsserver.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}

-- Add Lua binary paths to a collection
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

-- Lua Language Server (Sumneko)
nvim_lsp.sumneko_lua.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        path = runtime_path,
      },
      diagnostics = {
        globals = {'vim', 'love'},
        disable = {'lowercase-global'},
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

-- Rust Language Server (RustAnalyzer)
nvim_lsp.rust_analyzer.setup{
  on_attach = on_attach,
}

-- NvimCmp Autocompletion
-------------------------
local luasnip = require('luasnip')
local lspkind = require('lspkind')
local cmp = require('cmp')

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
  }, {
    { name = 'buffer' },
  }),
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol',
      maxwidth = 50,
    })
  },
})
