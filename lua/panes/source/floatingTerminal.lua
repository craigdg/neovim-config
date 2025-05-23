local Terminal = require('toggleterm.terminal').Terminal

local floatingTerminal = Terminal:new({
    direction = "float",
    border = "shadow",
    shade_terminals = true,
    on_open = function()
        vim.cmd("startinsert")
    end,
    on_close = function()
        vim.cmd("startinsert")
    end,
})

local function create()
    floatingTerminal:toggle()
end

return {
    create = create,
}
