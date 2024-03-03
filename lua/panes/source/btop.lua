local Terminal = require('toggleterm.terminal').Terminal

local btop = Terminal:new({
    cmd = "btop",
    direction = "float",
    on_open = function(term)
        vim.cmd("startinsert!")
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
    end,
    on_close = function()
        vim.cmd("startinsert!")
    end,
})

local function create()
    btop:toggle()
end

return {
    create = create,
}
