local Terminal = require('toggleterm.terminal').Terminal
local btop = Terminal:new({
    cmd = "btop",
    direction = "float"
})

local function create()
    vim.defer_fn(function()
        btop:toggle()
    end, 0)
end

return {
    create = create,
}
