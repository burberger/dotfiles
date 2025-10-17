-- Basic settings
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = 'yes'
vim.o.wrap = false

-- State file settings
vim.o.swapfile = false
vim.o.backup = false
vim.o.undofile = true

-- Indent settings
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.expandtab = true

-- Make Y behave like default vim
vim.api.nvim_set_keymap('n', 'Y', 'yy', {noremap = true})

-- Window navigation
vim.api.nvim_set_keymap('n', '<c-h>', '<c-w>h', {noremap = true})
vim.api.nvim_set_keymap('n', '<c-j>', '<c-w>j', {noremap = true})
vim.api.nvim_set_keymap('n', '<c-k>', '<c-w>k', {noremap = true})
vim.api.nvim_set_keymap('n', '<c-l>', '<c-w>l', {noremap = true})
-- Create splits
vim.api.nvim_set_keymap('n', '<leader>w', '<c-w>v<c-w>l', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>r', '<c-w>s<c-w>j', {noremap = true})

-- Clear search
vim.api.nvim_set_keymap('n', '<leader> ', ':noh<cr>', {noremap = true})

-- Telescope configs
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<c-p>', builtin.git_files, {noremap = true})
vim.keymap.set('n', '<c-s-p>', builtin.find_files, {noremap = true})
vim.keymap.set('n', '<c-s-f>', builtin.live_grep, {noremap = true})
vim.keymap.set('n', '<c-e>', builtin.diagnostics, {noremap = true})

-- Tree view
vim.keymap.set('n', '<leader>f', ':Neotree toggle<cr>', {noremap = true})
vim.keymap.set('n', '<leader>g', ':Neotree git_status toggle<cr>', {noremap = true})

-- Diagnostics
vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '✘',
            [vim.diagnostic.severity.WARN] = '▲',
            [vim.diagnostic.severity.HINT] = '⚑',
            [vim.diagnostic.severity.INFO] = '»',
        },
    },
    virtual_lines = {
        current_line = true,
    },
})

-- Statusline
require("lualine").setup({})

-- GUI configs and color scheme
if vim.loop.os_uname().sysname == "Darwin" then
    vim.o.guifont = "SauceCodePro NFM:h14"
else
    vim.o.guifont = "SauceCodePro NFM:h12"
end

vim.o.termguicolors = true
require("gruvbox").setup({
})
vim.cmd [[ colorscheme gruvbox ]]

-- GUI copy paste
if vim.g.neovide then
	vim.api.nvim_set_keymap('v', '<sc-c>', '"+y', {noremap = true})
	vim.api.nvim_set_keymap('n', '<sc-v>', '"+P', {noremap = true})
	vim.api.nvim_set_keymap('v', '<sc-v>', '"+P', {noremap = true})
    vim.api.nvim_set_keymap("c", "<sc-v>", "<C-R>0", { noremap = true })
	vim.api.nvim_set_keymap('i', '<sc-v>', '<ESC>"+p', {noremap = true})
	vim.api.nvim_set_keymap('t', '<sc-v>', '<C-\\><C-n>"+Pi', {noremap = true})
end

