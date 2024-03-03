local utils = require('utils.index')

local function is(buf)
    if vim.fn.bufname(buf):find("^NvimTree") then
        return true
    end

    return false
end

local function focus()
    for _, buf in pairs(utils.buffer.getVisibleWindows()) do
        if is(buf) then
            vim.api.nvim_set_current_win(utils.buffer.getWindowId(buf))
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', false)
            break
        end
    end
end

local function has()
    for _, buf in pairs(utils.buffer.getVisibleWindows()) do
        if is(buf) then
            return true
        end
    end

    return false
end

local function refresh()
    local current = vim.api.nvim_get_current_buf()

    if has() then
        vim.cmd("NvimTreeClose")
    end

    vim.cmd("NvimTreeOpen")

    if vim.api.nvim_buf_is_valid(current) then
        vim.cmd("buffer " .. current)
    end
end

local function create()
    vim.cmd("NvimTreeOpen")
end

local function hide()
    vim.cmd("NvimTreeClose")
end

local function toggle()
    vim.cmd("NvimTreeToggle")
end

return {
    is = is,
    has = has,
    focus = focus,
    create = create,
    hide = hide,
    refresh = refresh,
    toggle = toggle
}
