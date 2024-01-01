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
    "kdheepak/lazygit.nvim",
    "itspriddle/vim-shellcheck",
    "z0mbix/vim-shfmt",
    'nvim-tree/nvim-web-devicons',
    "nvim-tree/nvim-tree.lua",
    "jose-elias-alvarez/null-ls.nvim",
    "folke/trouble.nvim",
    "VonHeikemen/lsp-zero.nvim",
    'nvim-lua/plenary.nvim',
    "nvim-telescope/telescope.nvim",
    "neovim/nvim-lspconfig",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "L3MON4D3/LuaSnip",
    "williamboman/mason-lspconfig.nvim",
    "williamboman/mason.nvim",
})
