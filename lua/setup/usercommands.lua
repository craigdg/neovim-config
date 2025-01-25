local panes = require("panes.index")

vim.api.nvim_create_user_command(
    'EnsureEmpty',
    function()
        if not panes.file.has() and not panes.empty.has() then
            panes.tree.focus()

            vim.defer_fn(function()
                vim.o.splitright = true
                vim.cmd("vsplit")
                panes.empty.create()
                panes.tree.focus()
                vim.cmd("vertical resize " .. "50")
                panes.tree.refresh()
            end, 0)
        end
    end,
    { nargs = 0 }
)

vim.api.nvim_create_user_command(
    'FloatingTerminal',
    function()
        panes.floatingTerminal.create()
    end,
    { nargs = 0 }
)

vim.api.nvim_create_user_command(
    'FloatingTerminal',
    function()
        panes.floatingTerminal.create()
    end,
    { nargs = 0 }
)

vim.api.nvim_create_user_command(
    'ChatGPT',
    function()
        panes.chatgpt.create()
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
    'FocusFile',
    function()
        panes.file.focus()
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

vim.api.nvim_create_user_command(
    'Split',
    function()
        panes.file.focus()
        vim.cmd('vsplit<CR>')
    end,
    { nargs = 0 }
)
