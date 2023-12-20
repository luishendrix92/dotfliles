local keymap = vim.keymap

-- Set the leader keys to <space> (local leader is for buffer ops)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-------------------
-- General Mappings
-------------------

-- Turns off search result highlighting after a search with /
keymap.set("n", "<F4>", ":nohlsearch<Bar> :echo<CR>")

-- Navigate comfortably between windows
keymap.set("n", "<C-h>", "<C-w>h")
keymap.set("n", "<C-j>", "<C-w>j")
keymap.set("n", "<C-k>", "<C-w>k")
keymap.set("n", "<C-l>", "<C-w>l")

-- Resize windows with the keyboard arrows
keymap.set("n", "<C-Left>", ":vertical resize +2<CR>")
keymap.set("n", "<C-Right>", ":vertical resize -2<CR>")
keymap.set("n", "<C-Up>", ":resize +2<CR>")
keymap.set("n", "<C-Down>", ":resize -2<CR>")

-- Move to the next or previous buffer in the bufferline
keymap.set("n", "<S-Tab>", ":bprevious<CR>")
keymap.set("n", "<Tab>", ":bnext<CR>")

-- Stay in indent mode
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- Move lines and visual blocks up and down
keymap.set("n", "<A-j>", ":m .+1<CR>==")
keymap.set("n", "<A-k>", ":m .-2<CR>==")
keymap.set("x", "<A-j>", ":move '>+1<CR>gv-gv")
keymap.set("x", "<A-k>", ":move '<-2<CR>gv-gv")

-- Delete all lines of a buffer
keymap.set("n", "<leader>da", "ggVGd")

-- Delete character without copying it into a register
keymap.set("n", "x", '"_x')
