local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system(
        {
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branctable",
            lazypath
        }
    )
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    'nvim-tree/nvim-web-devicons',
    "lewis6991/gitsigns.nvim",
    'nvim-lua/plenary.nvim',
    "kdheepak/lazygit.nvim",
    "nvim-tree/nvim-tree.lua",
    "itspriddle/vim-shellcheck",
    "z0mbix/vim-shfmt",
    "jose-elias-alvarez/null-ls.nvim",
    "folke/trouble.nvim",
    "VonHeikemen/lsp-zero.nvim",
    "neovim/nvim-lspconfig",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "L3MON4D3/LuaSnip",
    "williamboman/mason-lspconfig.nvim",
    "williamboman/mason.nvim",
    "romgrk/barbar.nvim",
    "nvim-telescope/telescope.nvim",
})

vim.g.barbar_auto_setup = false

require 'barbar'.setup {
    maximum_padding = 10,
    minimum_padding = 10,
    highlight_inactive_file_icons = true,
    exclude_name = { '' },
    exclude_ft = { '' }
}
