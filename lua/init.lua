local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

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

vim.opt.rtp:prepend(lazypath)

require("plugins.lazy")
require("plugins.nvimtree")
require("plugins.lualine")
require("plugins.mason")
require("plugins.telescope")
require("setup.options")
require("setup.usercommands")
require("setup.autocommands")
require("setup.keymaps")
