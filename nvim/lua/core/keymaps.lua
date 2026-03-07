--n ~/.config/nvim/lua/core/keymaps.lua

local optsn= {noremap = true, silent = true}

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = "Limpiar resaltado de búsqueda" })

vim.keymap.set('n', '<A-h>', '<C-w>h', { desc = "Mover a la ventana izquierda" })
vim.keymap.set('n', '<A-j>', '<C-w>j', { desc = "Mover a la ventana inferior" })
vim.keymap.set('n', '<A-k>', '<C-w>k', { desc = "Mover a la ventana superior" })
vim.keymap.set('n', '<A-l>', '<C-w>l', { desc = "Mover a la ventana derecha" })
vim.keymap.set('n', '<A-w>', '<C-w>w', { desc = "Mover a la siguiente ventana" })
vim.keymap.set('n', '<A-p>', '<C-w>p', { desc = "Mover a la ventana anterior" })
