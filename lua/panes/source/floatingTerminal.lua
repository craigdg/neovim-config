local Terminal = require('toggleterm.terminal').Terminal
local function create()
    local floatingTerminal = Terminal:new({
        direction = "float",
        on_open = function()
            vim.cmd("startinsert!")
        end,
        on_close = function()
            vim.cmd("startinsert!")
        end,
    })

    floatingTerminal:toggle()
end

return {
    create = create,
}
