local plain_file = os.getenv("PLAIN_FILE")

local config = {
    terminal = {
        height = 10
    }
}

local memory = {
    terminals = {},
    terminal = {
        height = config.terminal.height
    }
}

local function isWindowVisible(window_id)
    local windows = vim.api.nvim_tabpage_list_wins(0)

    for _, win in ipairs(windows) do
        if win == window_id then
            return true
        end
    end

    return false
end

local function getBufWindowId(buf)
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_buf(win) == buf then
            return win
        end
    end

    return nil
end

local function getVisibleWindows()
    local windows = {}
    local index = 0

    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if isWindowVisible(getBufWindowId(buf)) then
            windows[index] = buf
            index = index + 1
        end
    end

    return windows
end

local function isRoot(buf)
    if vim.fn.bufname(buf) == vim.fn.getcwd() then
        return true
    end

    return false
end

local function isTerminal(buf)
    if vim.fn.bufname(buf):find("^term") then
        return true
    end

    return false
end

local function isEmpty(buf)
    if vim.fn.bufname(buf) == "" then
        return true
    end

    return false
end

local function isTree(buf)
    if vim.fn.bufname(buf):find("^NvimTree") then
        return true
    end

    return false
end

local function isDiagnostic(buf)
    if vim.api.nvim_buf_get_option(buf, 'filetype') == "Trouble" then
        return true
    else
        return false
    end
end

local function isFile(buf)
    if (isTerminal(buf) or isTree(buf) or isEmpty(buf) or isDiagnostic(buf) or isRoot(buf)) then
        return false
    else
        return true
    end
end

local function hasTree()
    for _, buf in pairs(getVisibleWindows()) do
        if isTree(buf) then
            return true
        end
    end

    return false
end


local function hasEmpty()
    for _, buf in pairs(getVisibleWindows()) do
        if isEmpty(buf) then
            return true
        end
    end

    return false
end

local function hasFile()
    for _, buf in pairs(getVisibleWindows()) do
        if isFile(buf) then
            return true
        end
    end

    return false
end

local function hasTerminal()
    for _, buf in pairs(getVisibleWindows()) do
        if isTerminal(buf) then
            return true
        end
    end

    return false
end

local function hasHiddenTerminal()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if isTerminal(buf) and not isWindowVisible(getBufWindowId(buf)) then
            return true
        end
    end

    return false
end

local function hasDiagnostic()
    for _, buf in pairs(getVisibleWindows()) do
        if isDiagnostic(buf) then
            return true
        end
    end

    return false
end

local function createTerminal()
    vim.wo.number = false
    vim.wo.relativenumber = false
    vim.cmd("setlocal wrap")
    vim.cmd("terminal")
    vim.cmd("resize " .. memory.terminal.height)
end

local function resizeTerminals()
    for _, buf in pairs(getVisibleWindows()) do
        if isTerminal(buf) then
            vim.api.nvim_win_set_height(getBufWindowId(buf), memory.terminal.height)
        end
    end
end

local function diagnostic(buf)
    print(vim.fn.bufname(buf), "name", isFile(buf), "file", isEmpty(buf), "empty", isDiagnostic(buf),
        "diagnostic", isTerminal(buf), "terminal", isTree(buf), "tree", buf, isRoot(buf), "root")
end

local function focusTree()
    for _, buf in pairs(getVisibleWindows()) do
        if isTree(buf) then
            vim.api.nvim_set_current_win(getBufWindowId(buf))
            break
        end
    end
end

local function focusTerminal()
    for _, buf in pairs(getVisibleWindows()) do
        if isTerminal(buf) then
            vim.api.nvim_set_current_win(getBufWindowId(buf))
            break
        end
    end
end

-- Startup

vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*",
    callback = function()
        if not plain_file then
            vim.cmd("NvimTreeOpen")
            vim.cmd("wincmd l")

            if not hasTerminal() then
                vim.cmd("split")
                vim.cmd("wincmd j")
                createTerminal()
            end

            resizeTerminals()
            focusTree()
        end
    end
})

-- Formatters

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.sh" },
    command = "Shfmt"
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.yaml", "*.yml" },
    command = "Prettier"
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.ts", "*.tsx", "*.js", "*.cjs", "*.lua", "*.toml", "*.go", "*.json" },
    command = "LspZeroFormat"
})

-- Ensure we have a file or empty file to display.

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    callback = function()
        vim.defer_fn(function()
            if not hasFile() and not hasEmpty() then
                if hasTerminal() then
                    local has_tree = hasTree()

                    if has_tree then
                        vim.cmd("NvimTreeClose")
                    end

                    vim.o.splitbelow = false
                    focusTerminal()
                    vim.cmd("split | wincmd K")

                    if has_tree then
                        vim.cmd("NvimTreeOpen")
                        vim.cmd("wincmd l")
                    end
                end

                if hasTree() and not hasTerminal() then
                    vim.o.splitright = true
                    focusTree()
                    vim.cmd("vsplit")
                end

                vim.cmd("enew")

                if hasTree() then
                    focusTree()
                    vim.cmd("vertical resize " .. "50")
                end
            end
        end, 0)
    end
})

-- Resize the terminals every time we change buffer

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    callback = function()
        vim.defer_fn(function()
            resizeTerminals()
        end, 0)
    end
})

-- Diagnostic tool for debugging type of window detection

vim.api.nvim_create_user_command(
    'BufferList',
    function()
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            diagnostic(buf)
        end
    end,
    { nargs = 0 }
)

vim.api.nvim_create_user_command(
    'DiagnosticsToggle',
    function()
        if hasDiagnostic() then
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
        if hasDiagnostic() then
            vim.cmd "TroubleClose"
        else
            vim.cmd "Trouble"
        end
    end,
    { nargs = 0 }
)

vim.api.nvim_create_user_command(
    'TerminalNew',
    function()
        for _, buf in ipairs(getVisibleWindows()) do
            if isTerminal(buf) then
                vim.api.nvim_set_current_win(getBufWindowId(buf))
                vim.cmd "vsplit"
                createTerminal()
                break
            end
        end
    end,
    { nargs = 0 }
)

vim.api.nvim_create_user_command(
    'TerminalShow',
    function()
        local current_buf = vim.fn.bufnr('%')

        vim.cmd("wincmd l")

        if not hasTerminal() then
            vim.o.splitbelow = true
            vim.cmd("split")
        end

        if not hasHiddenTerminal() then
            createTerminal()
        end

        focusTerminal()

        local win = vim.api.nvim_get_current_win()
        local index = 0

        vim.o.splitbelow = true

        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if isTerminal(buf) and not isWindowVisible(getBufWindowId(buf)) then
                if (index > 0) then
                    vim.cmd("vsplit")
                    vim.cmd("wincmd l")
                    win = vim.api.nvim_get_current_win()
                end

                index = index + 1
                vim.api.nvim_win_set_buf(win, buf)
            end
        end

        focusTerminal()
    end,
    { nargs = 0 }
)

vim.api.nvim_create_user_command(
    'TerminalHide',
    function()
        for _, buf in pairs(getVisibleWindows()) do
            if isTerminal(buf) then
                vim.api.nvim_set_current_win(getBufWindowId(buf))
                vim.cmd("hide")
            end
        end
    end,
    { nargs = 0 }
)

vim.api.nvim_create_user_command(
    'TerminalToggle',
    function()
        if hasTerminal() then
            vim.cmd("TerminalHide")
        else
            vim.cmd("TerminalShow")
        end
    end,
    { nargs = 0 }
)

vim.api.nvim_create_user_command(
    'TerminalToggleSizing',
    function()
        if hasTerminal() then
            focusTerminal()

            if memory.terminal.height > config.terminal.height then
                memory.terminal.height = config.terminal.height
            else
                memory.terminal.height = 999
            end

            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                if vim.api.nvim_buf_is_loaded(buf) and isTerminal(buf) then
                    vim.api.nvim_win_set_height(getBufWindowId(buf), memory.terminal.height)
                end
            end
        end
    end,
    { nargs = 0 }
)

vim.api.nvim_set_option('scrolloff', 9999)

if not vim.fn.exists(':VCenterCursor') then
    vim.cmd([[
        augroup VCenterCursor
            autocmd!
            autocmd OptionSet *,*.* lua if vim.fn.expand("<amatch>") == 'scrolloff' and vim.fn.exists('#VCenterCursor#WinEnter,WinNew,VimResized') then vim.cmd("au! VCenterCursor WinEnter,WinNew,VimResized") end
        augroup END
    ]])

    vim.cmd([[
        function! VCenterCursor()
            if not vim.fn.exists('#VCenterCursor#WinEnter,WinNew,VimResized')
                let s:default_scrolloff = vim.o.scrolloff
                let vim.o.scrolloff = vim.fn.winheight(vim.fn.win_getid()) / 2
                autocmd VCenterCursor WinEnter,WinNew,VimResized *,*.* lua vim.cmd("let &scrolloff = winheight(win_getid())/2")
            else
                autocmd! VCenterCursor WinEnter,WinNew,VimResized
                let vim.o.scrolloff = s:default_scrolloff
            endif
        endfunction
    ]])
end

vim.api.nvim_set_keymap('n', '<leader>zz', ':lua VCenterCursor()<CR>', { noremap = true, silent = true })
