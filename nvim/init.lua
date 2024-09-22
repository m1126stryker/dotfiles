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

vim.keymap.set({'n','v'}, '<C-h>', '<C-w><C-h>', {desc = 'Move focus to the left window'})
vim.keymap.set({'n','v'}, '<C-l>', '<C-w><C-l>', {desc = 'Move focus to the right window'})
vim.keymap.set({'n','v'}, '<C-k>', '<C-w><C-k>', {desc = 'Move focus to the upper window'})
vim.keymap.set({'n','v'}, '<C-j>', '<C-w><C-j>', {desc = 'Move focus to the lower window'})

vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function()
		vim.highlight.on_yank()
	end,
})

--require("config.lazy")
--require("lazy").setup("plugins")
