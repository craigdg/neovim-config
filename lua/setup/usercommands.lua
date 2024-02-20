local utils = require("utils.index")
local panes = require("panes.index")
local memory = require("memory")
local plain_file = os.getenv("PLAIN_FILE")

vim.api.nvim_create_user_command(
    'Setup',
    function()
        if not plain_file then
            panes.tree.create()

            vim.cmd("wincmd l")

            if not panes.terminal.has() then
                vim.cmd("split")
                vim.cmd("wincmd j")
                panes.terminal.create()
            end

            panes.terminal.resize()
            panes.tree.focus()
        end
    end,
    { nargs = 0 }
)

vim.api.nvim_create_user_command(
    'TerminalHide',
    function()
        panes.terminal.hide()
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
    'ShiftMode',
    function()
        for _, buf in pairs(utils.buffer.getVisibleWindows()) do
            vim.api.nvim_set_current_win(utils.buffer.getWindowId(buf))
            vim.cmd("hide")
        end
    end,
    { nargs = 0 }
)

vim.api.nvim_create_user_command(
    'TerminalClose',
    function()
        panes.terminal.toggle()
    end,
    { nargs = 0 }
)

vim.api.nvim_create_user_command(
    'TerminalCycle',
    function()
        panes.terminal.toggle()
    end,
    { nargs = 0 }
)

vim.api.nvim_create_user_command(
    'TerminalNew',
    function()
        for _, buf in ipairs(utils.buffer.getVisibleWindows()) do
            if panes.terminal.is(buf) then
                vim.api.nvim_set_current_win(utils.buffer.getWindowId(buf))
                vim.cmd "vsplit"
                panes.terminal.create()
                break
            end
        end
    end,
    { nargs = 0 }
)

vim.api.nvim_create_user_command(
    'TerminalShow',
    function()
        panes.terminal.show()
    end,
    { nargs = 0 }
)

vim.api.nvim_create_user_command(
    'TerminalToggleSizing',
    function()
        if panes.terminal.has() then
            if memory.state.terminal.height > memory.initial.terminal.height then
                memory.state.terminal.height = memory.initial.terminal.height
            else
                memory.state.terminal.height = 999
            end

            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                if vim.api.nvim_buf_is_loaded(buf) and panes.terminal.is(buf) then
                    vim.api.nvim_win_set_height(utils.buffer.getWindowId(buf), memory.state.terminal.height)
                end
            end
        end
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
        vim.api.nvim_command('startinsert!')
    end,
    { nargs = 0 }
)

vim.api.nvim_create_user_command(
    'DiagnosticsToggle',
    function()
        if panes.diagnostic.has() then
            vim.cmd "TroubleClose"
        else
            vim.cmd "Trouble document_diagnostics"
        end
    end,
    { nargs = 0 }
)

vim.api.nvim_create_user_command(
    'DiagnosticsWorkspaceToggle',
    function()
        if panes.diagnostic.has() then
            vim.cmd "TroubleClose"
        else
            vim.cmd "Trouble"
        end
    end,
    { nargs = 0 }
)
