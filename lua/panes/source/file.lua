local utils = require('utils.index')
local terminal = require('panes.source.terminal')
local root = require('panes.source.root')
local diagnostic = require('panes.source.diagnostic')
local tree = require('panes.source.tree')
local empty = require('panes.source.empty')

local function is(buf)
    if (terminal.is(buf) or tree.is(buf) or empty.is(buf) or diagnostic.is(buf) or root.is(buf)) then
        return false
    else
        return true
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
        if is(buf) then
            return true
        end
    end

    return false
end

local function focus()
    for _, buf in pairs(utils.buffer.getVisibleWindows()) do
        if is(buf) or empty.is(buf) then
            vim.api.nvim_set_current_win(utils.buffer.getWindowId(buf))
            break
        end
    end
end

return {
    is = is,
    has = has,
    focus = focus,
    hasHidden = hasHidden
}
