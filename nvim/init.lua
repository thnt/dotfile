-- GLOBAL --
vim.g.mapleader = ' '
vim.o.completeopt = 'menu,menuone,noselect'

-- OPTIONS --
vim.o.termguicolors = true
vim.o.cursorline = true
vim.wo.listchars = table.concat({ 
--	'eol:↴', 
	'trail:⋅', 
	'tab:>-', 
	'nbsp:+',
}, ',')

vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.list = true
vim.bo.shiftwidth = 4
vim.bo.tabstop = 4
vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'

-- CMD --
vim.cmd 'colorscheme onedark'
vim.cmd [[
	autocmd FileType javascript,javascriptreact,html,css setlocal shiftwidth=2 tabstop=2
]]

-- LOAD PLUGINS --
require('plugins')


-- KEY BINDING --
local map = vim.api.nvim_set_keymap

map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', {noremap = true})
map('n', '<leader>fn', '<cmd>Telescope file_browser<cr>', {noremap = true})
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', {noremap = true})
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>', {noremap = true})
map('n', '<leader>fr', '<cmd>Telescope lsp_references<cr>', {noremap = true})
map('n', '<leader>fs', '<cmd>Telescope lsp_document_symbols<cr>', {noremap = true})
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', {noremap = true})
map('n', '<leader>fm', '<cmd>Telescope marks<cr>', {noremap = true})
-- map('t', '<Esc>', '<C-\\><C-n>', {noremap = true})


