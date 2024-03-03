local utils = require('utils.index')
local Terminal = require('toggleterm.terminal').Terminal

local function is(buf)
    if vim.fn.bufname(buf):find("^term") then
        return true
    end

    return false
end

local function create()
    local terminal = Terminal:new()
    terminal:toggle()
end

local function focus()
    local visible = false

    vim.cmd("ToggleTermToggleAll")

    for _, buf in pairs(utils.buffer.getVisibleWindows()) do
        if is(buf) then
            visible = true
        end
    end

    if not visible then
        vim.cmd("ToggleTermToggleAll")
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

local function toggle()
    vim.cmd("ToggleTermToggleAll")
end

local function resize()
    for _, buf in pairs(utils.buffer.getVisibleWindows()) do
        if is(buf) then
            vim.api.nvim_win_set_height(utils.buffer.getWindowId(buf), 18)
        end
    end
end

return {
    create = create,
    is = is,
    focus = focus,
    has = has,
    toggle = toggle,
    resize = resize,
}
