local utils = require('utils.index')

local function is(buf)
    if vim.api.nvim_buf_get_option(buf, 'filetype') == "trouble" then
        return true
    else
        return false
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
    if has() then
        vim.cmd "Trouble diagnostics close"
    else
        vim.cmd "Trouble diagnostics open focus"
    end
end

local function toggleWithWorkspace()
    if has() then
        vim.cmd "TroubleClose"
    else
        vim.cmd "Trouble"
        vim.cmd("setlocal wrap")
    end
end

return {
    is = is,
    toggle = toggle,
    toggleWithWorkspace = toggleWithWorkspace,
    has = has
}
