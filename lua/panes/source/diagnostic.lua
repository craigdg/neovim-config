local utils = require('utils.index')

local function is(buf)
    if vim.api.nvim_buf_get_option(buf, 'filetype') == "Trouble" then
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

return {
    is = is,
    has = has
}
