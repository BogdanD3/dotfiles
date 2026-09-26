-- Indentation
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- Leader key
vim.g.mapleader = " "           -- leader key for custom shortcuts

-- Show line numbers
vim.wo.number = true            -- enable line numbers on the side

-- Clear search highlights
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')

-- Pane navigation with Ctrl + arrow keys
vim.keymap.set('n', '<C-Up>', ':wincmd k<CR>')     -- move to split above
vim.keymap.set('n', '<C-Down>', ':wincmd j<CR>')   -- move to split below
vim.keymap.set('n', '<C-Left>', ':wincmd h<CR>')   -- move to split left
vim.keymap.set('n', '<C-Right>', ':wincmd l<CR>')  -- move to split right


