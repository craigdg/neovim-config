local Terminal = require('toggleterm.terminal').Terminal

local function create()
    local btop = Terminal:new({
        cmd = "btop",
        direction = "float"
    })

    vim.defer_fn(function()
        btop:toggle()
    end, 0)
end

return {
    create = create,
}
