local nvimtree = require("nvim-tree")

nvimtree.setup({
    view = {
        width = 50,
    },
    filters = {
        custom = { '.DS_Store' },
    },
    update_focused_file = {
        enable = true,
    },
    git = {
        enable = true,
        ignore = false,
        timeout = 500,
    },
    renderer = {
        highlight_git = true,
        icons = {
            show = {
                git = true,
            },
        },
    },
})
