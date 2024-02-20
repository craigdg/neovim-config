local function isVisible(window_id)
    local windows = vim.api.nvim_tabpage_list_wins(0)

    for _, win in ipairs(windows) do
        if win == window_id then
            return true
        end
    end

    return false
end

local function getWindowId(buf)
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_buf(win) == buf then
            return win
        end
    end

    return nil
end

local function getVisibleWindows()
    local windows = {}
    local index = 0

    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if isVisible(getWindowId(buf)) then
            windows[index] = buf
            index = index + 1
        end
    end

    return windows
end

return {
    isVisible = isVisible,
    getVisibleWindows = getVisibleWindows,
    getWindowId = getWindowId
}
