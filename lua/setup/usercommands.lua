local panes = require("panes.index")

vim.api.nvim_create_user_command(
    'Setup',
    function()
        panes.terminal.create()
        panes.tree.create()
        panes.tree.focus()
    end,
    { nargs = 0 }
)

vim.api.nvim_create_user_command(
    'LazyGit',
    function()
        panes.lazygit.create()
    end,
    { nargs = 0 }
)

vim.api.nvim_create_user_command(
    'Btop',
    function()
        panes.btop.create()
    end,
    { nargs = 0 }
)

vim.api.nvim_create_user_command(
    'TerminalToggle',
    function()
        panes.terminal.toggle()
    end,
    { nargs = 0 }
)

vim.api.nvim_create_user_command(
    'TerminalNew',
    function()
        panes.terminal.create()
    end,
    { nargs = 0 }
)

vim.api.nvim_create_user_command(
    'FocusFile',
    function()
        panes.file.focus()
    end,
    { nargs = 0 }
)

vim.api.nvim_create_user_command(
    'FocusTerminal',
    function()
        panes.terminal.focus()
    end,
    { nargs = 0 }
)

vim.api.nvim_create_user_command(
    'DiagnosticsToggle',
    function()
        panes.diagnostic.toggle()
    end,
    { nargs = 0 }
)

vim.api.nvim_create_user_command(
    'DiagnosticsWorkspaceToggle',
    function()
        panes.diagnostic.toggleWithWorkspace()
    end,
    { nargs = 0 }
)
