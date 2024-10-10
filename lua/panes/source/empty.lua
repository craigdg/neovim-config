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
    -- Get the list of buffers
    local buffers = vim.api.nvim_list_bufs()

    -- Iterate through buffers to find the one with the name '[No Name]:1'
    for _, buf in ipairs(buffers) do
        local name = vim.api.nvim_buf_get_name(buf)
        if name == "" then
            local buftype = vim.api.nvim_buf_get_option(buf, "buftype")

            if buftype == "" then
                vim.api.nvim_buf_delete(buf, { force = true })
            end
        end
    end

    vim.wo.number = true
    vim.wo.relativenumber = true
    vim.cmd("enew")
end

return {
    is = is,
    has = has,
    create = create
}
