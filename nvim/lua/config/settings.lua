-- Basic settings
vim.o.relativenumber = true
vim.o.signcolumn = 'yes'
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
vim.keymap.set('n', '<c-p>', builtin.find_files, {noremap = true})
vim.keymap.set('n', '<c-s-f>', builtin.live_grep, {noremap = true})

-- Tree view
vim.keymap.set('n', '<leader>f', ':Neotree toggle<cr>', {noremap = true})
vim.keymap.set('n', '<leader>g', ':Neotree git_status toggle<cr>', {noremap = true})

-- Treesitter config
require('nvim-treesitter.configs').setup {
	ensure_installed = { 'c', 'cpp', 'css', 'typescript', 'html', 'lua', 'rust', 'tsx',
		'vhdl', 'yaml', 'python', 'bash', 'c_sharp', 'fsharp', 'go',
	},
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
		disable = function(lang, buf)
			local max_filesize = 100 * 1024 -- 100KB
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
			return false
		end,
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true,
	},
}

-- LSP Configs
-- Statusline
require("lualine").setup()

-- GUI configs and color scheme
if vim.loop.os_uname().sysname == "Darwin" then
    vim.o.guifont = "SauceCodePro NFM:h14"
else
    vim.o.guifont = "SauceCodePro NFM:h12"
end

vim.o.termguicolors = true
require("gruvbox").setup({
	italic = {
		strings = false,
		emphasis = false,
		comments = false,
		operators = false,
		folds = false,
	},
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

