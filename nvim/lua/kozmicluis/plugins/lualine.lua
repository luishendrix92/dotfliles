return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")

    lualine.setup({
      options = {
        theme = "auto",
        section_separators   = { left = "", right = "" },
        component_separators = { left = "|", right = "|" },
        disabled_filetypes = { "NvimTree" },
      },
    })
  end,
}
