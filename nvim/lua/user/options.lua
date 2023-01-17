local options = {
  backup = false, -- Creates backup files before overwriting
  clipboard = 'unnamedplus', -- Interacts with the system clipboard
  conceallevel = 2, -- Useful for Markdown, Latex, and symbols
  encoding = 'utf-8', -- Set default encoding to UTF-8
  mouse = 'a', -- Allow or disallow mouse interaction
  splitbelow = true, -- Create horizontal splits below the current one
  splitright = true, -- Create vertical splits to the right side
  swapfile = false, -- Creates a swapfile to simulate file recovery
  relativenumber = false, -- Line numbers above and below are relative
  cursorline = true, -- Highlights the line where the cursor is
  autoindent = true, -- Copies the indentation level of the previous line
  smartindent = true, -- Indents after <CR> depending on the language
  expandtab = true, -- Converts tabs to space characters
  shiftwidth = 2, -- When indenting lines using >> and <<, how many spaces
  softtabstop = 2, -- How many characters you move with <Tab> <Backspace>
  tabstop = 2, -- How many spaces a <Tab> is worth
  hlsearch = true, -- Highlights pattern search resuls
  number = true, -- Adds line numbering
  wrap = true, -- Exceeding characters will go to a new line
  completeopt = 'menu,menuone,noselect', -- Mostly for nvim-cmp
  background = 'dark', -- Light or Dark version of a colorscheme
  termguicolors = true, -- Some color schemes need it
  scrolloff = 8, -- Amount of line offset for scrolling vertically
  foldmethod = 'expr', -- Fold by expression, required by Treesitter
  foldexpr = 'nvim_treesitter#foldexpr()', -- Use Treesitter to determine folds
  foldenable = false, -- Show all folds, can be toggled with 'zi'
  list = true, -- Enable special buffer symbols
  listchars = { tab = ' ', trail = '·', eol = '¬' }
}

local globals = {}

-- Treat certain characters as part of a keyword (e.g. 'w')
vim.opt.iskeyword:append '-'

-- Add all options to vim.opt (behaves like 'set whatever')
for key, value in pairs(options) do
  vim.opt[key] = value
end

-- Global options (behaves like 'let g:whatever')
for key, value in pairs(globals) do
  vim.g[key] = value
end

vim.cmd('set guioptions-=e') -- Show tabline
