-- almost the same as kickstart.nvim since im still exploring :))

-- BASIC LAYOUT -- 

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.opt.breakindent = true
vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.signcolumn = 'yes'

vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.list = true
vim.opt.listchars = {tab = '» ',trail = '.', nbsp = '␣'}

vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 22

vim.opt.termguicolors = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.ph = 10

vim.schedule(function()
	vim.opt.clipboard = 'unnamedplus'
end)

-- KEYMAPS --
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set({'n','v'}, '<left>', '')
vim.keymap.set({'n','v'}, '<right>', '')
vim.keymap.set({'n','v'}, '<up>', '')
vim.keymap.set({'n','v'}, '<down>', '')

vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', { desc = 'move line up' })
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', { desc = 'move line down' })

vim.keymap.set('n', '<leader>=', '>i{', { desc = 'indent the inner block one tab to the right' })
vim.keymap.set('n', '<leader>+', '<i{', { desc = 'indent the inner block one tab to the left' })

vim.keymap.set({'n','v'}, '<leader>h', '<C-w><C-h>', {desc = 'Move focus to the left window'})
vim.keymap.set({'n','v'}, '<leader>l', '<C-w><C-l>', {desc = 'Move focus to the right window'})
vim.keymap.set({'n','v'}, '<leader>k', '<C-w><C-k>', {desc = 'Move focus to the upper window'})
vim.keymap.set({'n','v'}, '<leader>j', '<C-w><C-j>', {desc = 'Move focus to the lower window'})

vim.keymap.set('n', '<C-c><C-c>', '<cmd>ColorizerToggle<CR>', {desc = 'Toggle Colorizer on the current buffer'})

vim.keymap.set('x', '<leader>p', '\"_dP') --paste while preserving the yanked text
vim.keymap.set({'n','v'}, '<leader>y', '\"+y') --yank to system clipboard
vim.keymap.set('n', '<leader>Y', '\"+Y')

vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function()
		vim.highlight.on_yank()
	end,
})

require("config.lazy")
