local utils = require('utils.index')

local function is(buf)
    if vim.fn.bufname(buf) == "" then
        return true
    end

    return false
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
    vim.wo.number = true
    vim.wo.relativenumber = true
    vim.cmd("enew")
end

return {
    is = is,
    has = has,
    create = create
}
