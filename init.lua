local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system(
        {"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
         lazypath})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({"z0mbix/vim-shfmt", "itspriddle/vim-shellcheck", "bash-lsp/bash-language-server", "neovim/nvim-lspconfig", 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path',
                       'hrsh7th/cmp-cmdline', 'hrsh7th/nvim-cmp', 'hrsh7th/cmp-vsnip', 'hrsh7th/vim-vsnip',
                       'jose-elias-alvarez/null-ls.nvim', 'MunifTanjim/prettier.nvim', {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.4',
    dependencies = {'nvim-treesitter/nvim-treesitter', 'nvim-lua/plenary.nvim'}
}})

require'lspconfig'.tsserver.setup {}

local builtin = require('telescope.builtin')
vim.g.mapleader = "`"
vim.keymap.set('n', '<Leader>f', builtin.find_files, {})
vim.keymap.set('n', '<Leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<Leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<Leader>fh', builtin.help_tags, {})
vim.opt.termguicolors = false
vim.o.termguicolors = true
vim.wo.number = true
vim.opt.incsearch = true

vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {
    noremap = true,
    silent = true
})

vim.api.nvim_create_augroup("FormatAutogroup", {
    clear = true
})
vim.api.nvim_create_autocmd("BufWritePre", {
    group = "FormatAutogroup",
    pattern = {"*.ts", "*.tsx"},
    command = "Prettier"
})

vim.api.nvim_create_autocmd("BufWritePre", {
	group = "FormatAutogroup",
	pattern= {"*.sh"},
	command="Shfmt"
});

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'sh',
  callback = function()
    vim.lsp.start({
      name = 'bash-language-server',
      cmd = { 'bash-language-server', 'start' },
    })
  end,
})
vim.o.termguicolors = false

vim.cmd 'colorscheme kingpin'
local cmp = require 'cmp'

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({
            select = true
        })
    }),
    sources = cmp.config.sources({{
        name = 'nvim_lsp'
    }, {
        name = 'vsnip'
    }}, {{
        name = 'buffer'
    }})
})

