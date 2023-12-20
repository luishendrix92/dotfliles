return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local capabilities = cmp_nvim_lsp.default_capabilities()

    local on_attach = function(_, bufnr)
      local opts = { noremap = true, silent = true }
      local keymap = vim.keymap

      opts.buffer = bufnr

      keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
      keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
      keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      keymap.set("n", "gr", vim.lsp.buf.references, opts)
      keymap.set("n", "K", vim.lsp.buf.hover, opts)
      keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)
      keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      keymap.set("n", "<leader>fd", function()
        vim.lsp.buf.format { async = true }
      end, opts)
    end

    -- Lua Language Server
    lspconfig["lua_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT'
          },
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME
            }
          }
        }
      }
    })

    -- OCaml Language Server
    lspconfig["ocamllsp"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- Typescript Language Server
    lspconfig["tsserver"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
  end,
}
