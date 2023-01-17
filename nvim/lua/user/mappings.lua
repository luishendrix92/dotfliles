local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Set the leader keys to <space> (local leader is for buffer ops)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Turns off search result highlighting after a search with /
keymap('n', '<F4>', ':nohlsearch<Bar> :echo<CR>', opts)

-- Navigate comfortably between windows
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)

-- Resize windows with the keyboard arrows
keymap('n', '<C-Left>', ':vertical resize +2<CR>', opts)
keymap('n', '<C-Right>', ':vertical resize -2<CR>', opts)
keymap('n', '<C-Up>', ':resize +2<CR>', opts)
keymap('n', '<C-Down>', ':resize -2<CR>', opts)

-- Move to the next or previous buffer in the bufferline
keymap('n', '<S-Tab>', ':bprevious<CR>', opts)
keymap('n', '<Tab>', ':bnext<CR>', opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move lines and visual blocks up and down
keymap('n', '<A-j>', ':m .+1<CR>==', opts)
keymap('n', '<A-k>', ':m .-2<CR>==', opts)
keymap('x', '<A-j>', ":move '>+1<CR>gv-gv", opts)
keymap('x', '<A-k>', ":move '<-2<CR>gv-gv", opts)

-- Split line (opposite of 'J')
keymap('n', '<leader>bl', [[xi
==]], opts) -- Gets rid of character at cursor

-- Delete all lines of a buffer
keymap('n', '<leader>da', 'ggVGd', opts)

keymap('n', '<leader>mr', '<Plug>RestNvim', opts)
