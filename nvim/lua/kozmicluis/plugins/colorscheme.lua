-- Moonfly Color Scheme
---------------------------------------
-- return {
--   "bluz71/vim-moonfly-colors",
--   name = "moonfly",
--   priority = 1000,
--   config = function()
--     vim.cmd([[colorscheme moonfly]])
--   end,
-- }

-- Catppuccin Color Scheme
---------------------------------------
return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      dim_inactive = {
        enabled = true,
        shade = "dark",
        percentage = 0.15,
      },
      no_italic = true,
    })

    vim.cmd.colorscheme "catppuccin"
  end
}
