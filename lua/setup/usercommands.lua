local panes = require("panes.index")

vim.api.nvim_create_user_command(
    'Setup',
    function()
        --panes.terminal.create()
        --panes.tree.create()
        --panes.tree.focus()
    end,
    { nargs = 0 }
)

vim.api.nvim_create_user_command(
    'EnsureEmpty',
    function()
        if not panes.file.has() and not panes.empty.has() then
            panes.tree.focus()

            vim.defer_fn(function()
                local had = panes.terminal.has()

                if panes.terminal.has() then
                    panes.terminal.toggle()
                end

                vim.o.splitright = true
                vim.cmd("vsplit")
                panes.empty.create()

                if had then
                    panes.terminal.toggle()
                end

                panes.tree.focus()
                vim.cmd("vertical resize " .. "50")
                panes.terminal.resize()
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
    'TerminalToggle',
    function()
        panes.terminal.toggle()
        panes.tree.refresh()
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

        if panes.tree.has() then
            panes.tree.refresh()
        end
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
