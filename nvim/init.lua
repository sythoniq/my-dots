-- ===================== --
-- ====== Keymaps ====== --
-- ===================== --

-- Space as leader key
vim.g.mapleader = ' '

-- Shortcuts
vim.keymap.set({'n', 'x', 'o'}, '<leader>h', '^')
vim.keymap.set({'n', 'x', 'o'}, '<leader>l', 'g_')
vim.keymap.set('n', '<leader>a', ':keepjumps normal! ggVG<cr>')
vim.keymap.set('n', '<leader><leader>', vim.cmd.Ex)

-- Basic clipboard interaction
vim.keymap.set({'n', 'x'}, '<leader>y', '"+y') -- copy
vim.keymap.set({'n', 'x'}, '<leader>p', '"+p') -- paste

-- Move entire blocks of text
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Simple nav improvement..
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Tab/split stuff
vim.keymap.set('n', '<leader>sv', '<C-w>v')
vim.keymap.set('n', '<leader>sh', '<C-w>h')
vim.keymap.set('n', '<leader>zz', '<C-w>w')
vim.keymap.set('n', '<leader>sx', '<cmd>close<CR>')
vim.keymap.set('n', '<leader>se', '<C-w>=')

-- Delete text
vim.keymap.set({'n', 'x'}, 'x', '"_x')
vim.keymap.set({'n', 'x'}, 'X', '"_d')

-- Commands
vim.keymap.set('n', '<leader>q', '<cmd>quit<cr>')
vim.keymap.set('n', '<leader>w', '<cmd>write<cr>')

-- ===================== --
-- ====== Options ====== --
-- ===================== --
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.wrap = true
vim.opt.smartindent = true
vim.opt.breakindent = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = false
vim.opt.scrolloff = 20

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.colorcolumn = "90"
vim.opt.termguicolors = true

-- ===================== --
-- ====== Plugins ====== --
-- ===================== --

-- Colorscheme
vim.pack.add { { src = "https://github.com/catppuccin/nvim", name = "catppuccin" } }
require("catppuccin").setup({
	flavor = "mocha",
	transparent_background = true,
	no_italic = true,
	no_bold = true,
})

vim.cmd.colorscheme "catppuccin-nvim"


-- Auto pair
vim.pack.add{ { src="https://github.com/windwp/nvim-autopairs.git", name = "autopair" } }
require("nvim-autopairs").setup({
	enabled = function(bufnr) return true end, -- control if auto-pairs should be enabled when attaching to a buffer
	disable_in_macro = true, -- disable when recording or executing a macro
	disable_in_visualblock = false, -- disable when insert after visual block mode
	disable_in_replace_mode = true,
	ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
	enable_moveright = true,
	enable_afterquote = true, -- add bracket pairs after quote
	enable_check_bracket_line = true, --- check bracket in same line
	enable_bracket_in_quote = true, --
	enable_abbr = false, -- trigger abbreviation
	break_undo = true, -- switch for basic rule break undo sequence
	check_ts = false,
	map_cr = true,
	map_bs = true, -- map the <BS> key
	map_c_h = false, -- Map the <C-h> key to delete a pair
	map_c_w = false, -- map <c-w> to delete a pair if possible
})

-- Todo comments
vim.pack.add{ { src="https://github.com/folke/todo-comments.nvim.git", name = "todo"} }
require("todo-comments").setup({
	keywords = {
		TODO = { icon = " ", color = "info" , alt = {"Personal"} },
	  ERROR = { icon = " ", color = "warning", alt = { "DON SKIP" } },
	},
	-- Patterns for hl markdown support
	highlight = {
		multiline = true,
		multiline_pattern = "^.",
		multiline_context = 10,
		before = "",
		keyword = "wide",
		after = "fg",
		pattern = {
			[[.*<(KEYWORDS)\s*:]], -- default pattern
			[[<!--\s*(KEYWORDS)\s*:.*-->]], -- HTML comments with colon
			[[<!--\s*(KEYWORDS)\s*.*-->]], -- HTML comments without colon
		},
		comments_only = false, -- highlighting outside of comments
	},
	search = {
		command = "rg",
		args = {
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
		},
		pattern = [[\b(KEYWORDS)\b]],
	},
})

-- Treesitter ( Stolen from kickstart nvim )
vim.pack.add{ { src= 'https://github.com/nvim-treesitter/nvim-treesitter.git', name="treesitter" } }
local parsers = { 'bash', 'c', 'diff', 'html', 'lua', 'markdown', 'markdown_inline', 'vim' }
require('nvim-treesitter').install(parsers)

---@param buf integer
---@param language string
local function treesitter_try_attach(buf, language)
	-- Check if a parser exists and load it
	if not vim.treesitter.language.add(language) then return end
	-- Enable syntax highlighting and other treesitter features
	vim.treesitter.start(buf, language)

	-- Enable treesitter based folds
	-- For more info on folds see `:help folds`
	-- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
	-- vim.wo.foldmethod = 'indent'

	-- Check if treesitter indentation is available for this language, and if so enable it
	-- in case there is no indent query, the indentexpr will fallback to the vim's built in one
	local has_indent_query = vim.treesitter.query.get(language, 'indents') ~= nil

	-- Enable treesitter based indentation
	if has_indent_query then vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end
end

local available_parsers = require('nvim-treesitter').get_available()
vim.api.nvim_create_autocmd('FileType', {
	callback = function(args)
		local buf, filetype = args.buf, args.match

		local language = vim.treesitter.language.get_lang(filetype)
		if not language then return end

		local installed_parsers = require('nvim-treesitter').get_installed 'parsers'

		if vim.tbl_contains(installed_parsers, language) then
			-- Enable the parser if it is already installed
			treesitter_try_attach(buf, language)
		elseif vim.tbl_contains(available_parsers, language) then
			-- If a parser is available in `nvim-treesitter`, auto-install it and enable it after the installation is done
			require('nvim-treesitter').install(language):await(function() treesitter_try_attach(buf, language) end)
		else
			-- Try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
			treesitter_try_attach(buf, language)
		end
	end,
})
