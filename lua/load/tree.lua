local tree = require("nvim-tree")

tree.setup({
    view = {
        width = 45,
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
