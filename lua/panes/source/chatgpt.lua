local Terminal = require('toggleterm.terminal').Terminal
local chatgpt = Terminal:new({
    cmd = "chatgpt",
    direction = "float"
})

local function create()
    vim.defer_fn(function()
        chatgpt:toggle()
    end, 0)
end

return {
    create = create,
}
