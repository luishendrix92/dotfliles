local nvim_lsp = require("lspconfig")
local root_pattern = nvim_lsp.util.root_pattern
-- Enables autocompletion for LSP artifacts via nvim-cmp
local capabilities = require('cmp_nvim_lsp')
    .update_capabilities(
      vim.lsp.protocol.make_client_capabilities()
    )

-- Highlights lines numbers with diagnostics (error, warning, info, hint)
vim.cmd [[
  highlight! DiagnosticLineNrError guibg=#51202A guifg=#FF0000 gui=bold
  highlight! DiagnosticLineNrWarn guibg=#51412A guifg=#FFA500 gui=bold
  highlight! DiagnosticLineNrInfo guibg=#1E535D guifg=#00FFFF gui=bold
  highlight! DiagnosticLineNrHint guibg=#1E205D guifg=#0000FF gui=bold

  sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=DiagnosticLineNrError
  sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=DiagnosticLineNrWarn
  sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=DiagnosticLineNrInfo
  sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=DiagnosticLineNrHint
]]

local on_attach = function(_, bufnr) -- If the first argument is used, call it 'client'
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  local opts = { noremap = true, silent = true }

  -- Enable manual OmniFunc completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Bind these keys when buffer is atached to an LSP.
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>d', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<leader>fd', '<cmd>lua vim.lsp.buf.format()<CR>', opts)
  buf_set_keymap('v', '<leader>fr', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
end

-- Individual language server configurations
-- -----------------------------------------
nvim_lsp.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

nvim_lsp.eslint.setup {}

-- Lua Language Server (Sumneko)
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

nvim_lsp.sumneko_lua.setup {
  on_attach = on_attach,
  single_file_support = false,
  root_dir = root_pattern('init.lua'),
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = runtime_path,
      },
      diagnostics = {
        globals = { 'vim', 'love' },
        disable = { 'lowercase-global' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      }
    }
  }
}

nvim_lsp.rust_analyzer.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

-- VSCode Extracted
nvim_lsp.cssls.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

nvim_lsp.html.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

nvim_lsp.jsonls.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

-- Standalone Emmet LSP
nvim_lsp.emmet_ls.setup {
  filetypes = {
    'html',
    'typescriptreact',
    'javascriptreact',
    'css',
    'jsp',
    'xml'
  }
}

-- Python Language Server
nvim_lsp.pylsp.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

-- Elm Language Server
nvim_lsp.elmls.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

-- Java Language Server via Eclipse JDTLS
nvim_lsp.jdtls.setup {
  cmd = { 'jdtls' },
  on_attach = on_attach,
  capabilities = capabilities
}

--require "lsp_signature".setup({
--  bind = true,
--  handler_opts = {
--    border = "rounded"
--  }
--})
