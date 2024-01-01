local terminal_height = 15
local hidden_terminals = {}
local plain_file = os.getenv("PLAIN_FILE")

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

local function isTerminal(buf)
    if vim.fn.bufname(buf):find("^term") then
        return true
    end

    return false
end

local function isEmpty(buf)
    if vim.fn.bufname(buf) == "" then
        return false
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
    if isTerminal(buf) or isTree(buf) or isEmpty(buf) or isDiagnostic(buf) then
        return false
    else
        return true
    end
end

local function isDiagnosticsOpened()
    for _, buf in pairs(vim.api.nvim_list_bufs()) do
        if isDiagnostic(buf) and isWindowVisible(getBufWindowId(buf)) then
            return true
        end
    end

    return false
end

local function isTerminalOpened()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if isTerminal(buf) and isWindowVisible(getBufWindowId(buf)) then
            return true
        end
    end

    return false
end

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.sh" },
    command = "Shfmt"
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.ts", "*.tsx", "*.lua", "*.toml", "*.go", "*.json" },
    command = "LspZeroFormat"
})

vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*",
    callback = function()
        if not plain_file then
            vim.cmd("NvimTreeToggle")
            vim.cmd("wincmd l")
            vim.cmd("split")
            vim.cmd("wincmd j")
            vim.wo.number = false
            vim.wo.relativenumber = false
            vim.cmd("resize " .. terminal_height)
            vim.cmd("terminal")
            vim.cmd("NvimTreeOpen")
        end
    end
})

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    callback = function()
        vim.defer_fn(function()
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                if isTerminal(buf) and isWindowVisible(getBufWindowId(buf)) then
                    vim.api.nvim_win_set_height(getBufWindowId(buf), terminal_height)
                end
            end
        end, 0)
    end
})

vim.api.nvim_create_user_command(
    'HighlightGroup',
    function()
        vim.api.nvim_exec([[echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')]], true)
    end,
    { nargs = 0 }
)

vim.api.nvim_create_user_command(
    'FilesClose',
    function()
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if isFile(buf) and vim.api.nvim_buf_is_valid(buf) then
                vim.cmd("bdelete " .. buf)
            end
        end
    end,
    { nargs = 0 }
)

vim.api.nvim_create_user_command(
    'BufferList',
    function()
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            print(vim.fn.bufname(buf), "name", isFile(buf), "file", isEmpty(buf), "empty", isDiagnostic(buf),
                "diagnostic", isTerminal(buf), "terminal", isTree(buf), "tree", buf, "buf")
        end
    end,
    { nargs = 0 }
)

vim.api.nvim_create_user_command(
    'DiagnosticsToggle',
    function()
        if isDiagnosticsOpened() then
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
        if isTerminalOpened() then
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                if isTerminal(buf) then
                    vim.api.nvim_set_current_win(getBufWindowId(buf))
                    vim.wo.number = false
                    vim.wo.relativenumber = false
                    vim.cmd "vsplit"
                    vim.cmd "terminal"
                    break
                end
            end
        end
    end,
    { nargs = 0 }
)

vim.api.nvim_create_user_command(
    'TerminalShow',
    function()
        vim.cmd("wincmd l")
        vim.cmd("split")
        vim.cmd("wincmd j")

        local has_terminals = false

        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if isTerminal(buf) then
                has_terminals = true
                break
            end
        end

        if not has_terminals then
            vim.wo.number = false
            vim.wo.relativenumber = false
            vim.cmd("terminal")
        end

        local win = vim.api.nvim_get_current_win()
        local index = 0

        for _, buf in pairs(hidden_terminals) do
            if (index > 0) then
                vim.cmd("vsplit")
                vim.cmd("wincmd l")
                win = vim.api.nvim_get_current_win()
            end

            index = index + 1
            vim.api.nvim_win_set_buf(win, buf)
        end

        hidden_terminals = {}
    end,
    { nargs = 0 }
)

vim.api.nvim_create_user_command(
    'TerminalHide',
    function()
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_buf_is_loaded(buf) and isTerminal(buf) then
                hidden_terminals[getBufWindowId(buf)] = buf
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
        if isTerminalOpened() then
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
        if terminal_height > 15 then
            terminal_height = 15
        else
            terminal_height = 100
        end

        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_buf_is_loaded(buf) and isTerminal(buf) then
                vim.api.nvim_win_set_height(getBufWindowId(buf), terminal_height)
            end
        end
    end,
    { nargs = 0 }
)
