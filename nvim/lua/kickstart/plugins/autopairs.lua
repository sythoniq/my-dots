-- autopairs
-- https://github.com/windwp/nvim-autopairs

vim.pack.add { 'https://github.com/windwp/nvim-autopairs' }
require('nvim-autopairs').setup {
				enable_afterquote = false, check_ts = true, -- treesitter enabled
            ts_config = {
                lua = { "string" }, -- dont add pairs in lua string treesitter nodes
                -- javascript = { "template_string" }, -- dont add pairs in javscript template_string treesitter nodes
                java = false, -- dont check treesitter on java
            },
}
