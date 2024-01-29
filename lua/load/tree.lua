local tree = require("nvim-tree")

tree.setup({
    view = {
        width = 50,
    },
    filters = {
        dotfiles = false,
        custom = { '.DS_Store', '.git' },
    },
    update_focused_file = {
        enable = true,
    },
})
