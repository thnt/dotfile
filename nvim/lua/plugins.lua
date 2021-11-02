local packer = require('packer')
packer.startup(function()
    use 'wbthomason/packer.nvim'
	
	use 'neovim/nvim-lspconfig'

	use 'nvim-treesitter/nvim-treesitter'
	
	use 'challenger-deep-theme/vim'
	
	use {
		'hrsh7th/nvim-cmp',
		requires = {
			{ 'hrsh7th/cmp-buffer' },
			{ 'hrsh7th/cmp-path' },
			{ 'hrsh7th/cmp-nvim-lsp' },
			{ 'hrsh7th/cmp-nvim-lua' },
		}
	}

	use 'joshdick/onedark.vim'

   use {
        'nvim-telescope/telescope.nvim',
	   requires = { {'nvim-lua/plenary.nvim'} }
    }

	use 'nvim-lua/lsp-status.nvim'

	use {
		'nvim-lualine/lualine.nvim',
		requires = {'kyazdani42/nvim-web-devicons', opt = true}
	}

	use {
		'lewis6991/gitsigns.nvim',
		require = { 'nvim-lua/plenary.nvim' },
		config = function()
			require('gitsigns').setup()
		end
    }

	use {
		'lukas-reineke/indent-blankline.nvim',
		config = function()
			require('indent_blankline').setup{
--				char = '🭰',
				space_char = '⋅',
	--			space_char_blankline = '⋅',
				use_treesitter = true,
				show_current_context = true,
				show_trailing_blankline_indent = false,
				filetype_exclude = { 'help' },
			}
		end
	}

	use {
		'folke/which-key.nvim',
		config = function() require('which-key').setup{} end
	}

--	use 'github/copilot.vim'
	
	use {
		'ThePrimeagen/harpoon',
		requires = { 'nvim-lua/popup.nvim' }
	}

end)

-- TREESITTER CONFIG --
local treesitter = require('nvim-treesitter.configs')
treesitter.setup {
	ensure_installed = 'maintained',
	highlight = { enable = true },
}

-- LSP CONFIG --
local lsp = require 'lspconfig'
local lsp_status = require('lsp-status')
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
lsp_status.config({
	status_symbol = '',
	indicator_ok = '✓',
	update_interval = 1
})
lsp_status.register_progress()
local servers = { 'gopls' }
for _, s in ipairs(servers) do
	local handlers = nil
	if lsp_status.extensions[s] then
		handlers = lsp_status.extensions[s].setup()
	end
	
	lsp[s].setup{
		handlers = handlers,
		on_attach = lsp_status.on_attach,
		capabilities = capabilities,
	}
end

-- lualine --
require('lualine').setup {
	options = {
		theme = 'onedark',
--		section_separators = { left = '', right = '' },
--		component_separators = { left = '', right = '' },
	},
	sections = {
		lualine_b = { 'branch' },
		lualine_c = { 
			{ 'buffers', show_filename_only = false, icons_enabled = false },
			{ 'diff', diff_color = { 
				added = { fg = '#98c379' }, 
				modified = { fg = '#e5c07b' },
				removed = { fg = '#e06c75' }
			}},
		},
		lualine_x = {
			{ function() return require"lsp-status".status() end },
			{ 'filetype', icons_enabled = false },
			{ 'fileformat', icons_enabled = false },
			'encoding',
		}
	}
}

-- nvim-cmp --
local cmp = require'cmp'
cmp.setup {
	mapping = {
		['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
		['<CR>'] = cmp.mapping.confirm({select = true}),
--		['<C-e>'] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() })
	},
	sources = cmp.config.sources({
		{ name = 'path' },
		{ name = 'nvim_lsp' },
		{ name = 'buffer' },
		{ name = 'nvim_lua' },
	})
}
