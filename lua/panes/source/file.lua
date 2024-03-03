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

local function focus()
    for _, buf in pairs(utils.buffer.getVisibleWindows()) do
        if is(buf) or empty.is(buf) then
            vim.api.nvim_set_current_win(utils.buffer.getWindowId(buf))
            break
        end
    end
end

local function ensure()
    if not has() and not empty.has() then
        if terminal.has() then
            local has_tree = terminal.has()

            if has_tree then
                vim.cmd("NvimTreeClose")
            end

            vim.o.splitbelow = false
            terminal.focus()
            vim.cmd("split | wincmd K")

            if has_tree then
                vim.cmd("NvimTreeOpen")
                vim.cmd("wincmd l")
            end
        end

        if terminal.has() and not terminal.has() then
            vim.o.splitright = true
            tree.focus()
            vim.cmd("vsplit")
        end

        empty.create()

        if terminal.has() then
            tree.focus()
            vim.cmd("vertical resize " .. "50")
        end
    end
end

return {
    is = is,
    has = has,
    focus = focus,
    ensure = ensure
}
