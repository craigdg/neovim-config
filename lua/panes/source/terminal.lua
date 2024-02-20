local utils = require('utils.index')
local memory = require('memory')

local function is(buf)
    if vim.fn.bufname(buf):find("^term") then
        return true
    end

    return false
end

local function create()
    vim.wo.number = false
    vim.wo.relativenumber = false
    vim.cmd("setlocal wrap")
    vim.cmd("terminal")
    vim.cmd("resize " .. memory.state.terminal.height)
end

local function resize()
    for _, buf in pairs(utils.buffer.getVisibleWindows()) do
        if is(buf) then
            vim.api.nvim_win_set_height(utils.buffer.getWindowId(buf), memory.state.terminal.height)
        end
    end
end

local function focus()
    for _, buf in pairs(utils.buffer.getVisibleWindows()) do
        if is(buf) then
            vim.api.nvim_set_current_win(utils.buffer.getWindowId(buf))
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

local function hasHidden()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if is(buf) and not utils.buffer.isVisible(utils.buffer.getWindowId(buf)) then
            return true
        end
    end

    return false
end

local function hide()
    for _, buf in pairs(utils.buffer.getVisibleWindows()) do
        if is(buf) then
            vim.api.nvim_set_current_win(utils.buffer.getWindowId(buf))
            vim.cmd("hide")
        end
    end
end

local function show()
    local current = vim.fn.bufnr('%')

    vim.cmd("wincmd l")

    if not has() then
        vim.o.splitbelow = true
        vim.cmd("split")
    end

    if not hasHidden() then
        create()
    end

    focus()

    local win = vim.api.nvim_get_current_win()
    local index = 0

    vim.o.splitbelow = true

    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if is(buf) and not utils.buffer.isVisible(utils.buffer.getWindowId(buf)) then
            if (index > 0) then
                vim.cmd("vsplit")
                vim.cmd("wincmd l")
                win = vim.api.nvim_get_current_win()
            end

            index = index + 1
            vim.api.nvim_win_set_buf(win, buf)
        end
    end

    vim.api.nvim_set_current_win(utils.buffer.getWindowId(current))
end

local function toggle()
    if has() then
        hide()
    else
        show()
    end
end

return {
    create = create,
    resize = resize,
    is = is,
    focus = focus,
    has = has,
    hasHidden = hasHidden,
    hide = hide,
    toggle = toggle,
    show = show
}
