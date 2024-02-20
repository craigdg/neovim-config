local function is(buf)
    if vim.fn.bufname(buf) == vim.fn.getcwd() then
        return true
    end

    return false
end

return {
    is = is
}
