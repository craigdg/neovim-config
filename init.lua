local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system(
        {
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable",
            lazypath
        }
    )
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    'eandrju/cellular-automaton.nvim',
    "nvim-tree/nvim-web-devicons",
    "nvim-tree/nvim-tree.lua",
    'jose-elias-alvarez/null-ls.nvim',
    "folke/trouble.nvim",
    "itspriddle/vim-shellcheck",
    "bash-lsp/bash-language-server",
    'VonHeikemen/lsp-zero.nvim',
    "neovim/nvim-lspconfig",
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'L3MON4D3/LuaSnip',
    'hrsh7th/nvim-cmp',
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.4',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-lua/plenary.nvim' }
    },
    'nvim-treesitter/nvim-treesitter',
    "z0mbix/vim-shfmt",
    'nvim-lua/plenary.nvim'
})

local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(_, bufnr)
    lsp_zero.default_keymaps({ buffer = bufnr })
end)

local lua_opts = lsp_zero.nvim_lua_ls()
require('lspconfig').lua_ls.setup(lua_opts)
require("nvim-tree").setup()

lsp_zero.setup_servers({ 'tsserver', 'lua_ls', 'bashls' })

local trouble = require("trouble.providers.telescope")
local telescope = require("telescope")

telescope.setup {
    defaults = {
        mappings = {
            i = { ["<c-t>"] = trouble.open_with_trouble },
            n = { ["<c-t>"] = trouble.open_with_trouble },
        },
    },
}

local builtin = require('telescope.builtin')

vim.g.mapleader = "`"
vim.keymap.set('n', '<Leader>f', builtin.find_files, {})
vim.keymap.set('n', '<Leader>g', builtin.live_grep, {})
vim.keymap.set('n', '<Leader>b', builtin.buffers, {})
vim.keymap.set('n', '<Leader>h', builtin.help_tags, {})
vim.keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>")
vim.keymap.set("n", "<leader>v", "<cmd>Trouble<CR> <cmd>NvimTreeOpen<CR>")
vim.keymap.set("n", "<leader>c", "<cmd>TroubleClose<CR> <cmd>NvimTreeClose<CR>")
vim.keymap.set("n", "<leader>d", "<cmd>Trouble<CR>")
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeFocus<CR>")

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.incsearch = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.termguicolors = false

vim.cmd 'colorscheme kingpin'

vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {
    noremap = true,
    silent = true
})

vim.api.nvim_create_augroup("FormatAutogroup", {
    clear = true
})

vim.api.nvim_create_autocmd("BufWritePre", {
    group = "FormatAutogroup",
    pattern = { "*.sh" },
    command = "Shfmt"
});

vim.api.nvim_create_autocmd("BufWritePre", {
    group = "FormatAutogroup",
    pattern = { "*.ts", "*.tsx", "*.lua" },
    command = "LspZeroFormat"
})

vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*",
    command = "Trouble"
})

vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*",
    command = "NvimTreeToggle"
})

local cmp = require('cmp')
local cmp_action = lsp_zero.cmp_action()

cmp.setup({
    mapping = cmp.mapping.preset.insert({
        -- `Enter` key to confirm completion
        ['<CR>'] = cmp.mapping.confirm({ select = false }),

        -- Ctrl+Space to trigger completion menu
        ['<C-Space>'] = cmp.mapping.complete(),

        -- Navigate between snippet placeholder
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),

        -- Scroll up and down in the completion documentation
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
    })
})
