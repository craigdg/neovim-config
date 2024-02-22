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


local function create()
    vim.cmd("NvimTreeOpen")
    vim.wo.number = true
    vim.wo.relativenumber = true
end

local function hide()
    vim.cmd("NvimTreeClose")
end

return {
    is = is,
    has = has,
    focus = focus,
    create = create,
    hide = hide
}
