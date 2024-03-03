local Terminal = require('toggleterm.terminal').Terminal

local function create()
    local lazygit = Terminal:new({
        cmd = "lazygit",
        dir = "git_dir",
        direction = "float",
        on_open = function(term)
            vim.cmd("startinsert!")
            vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
        end,
        on_close = function(term)
            vim.cmd("startinsert!")
        end,
    })

    lazygit:toggle()
end

return {
    create = create,
}
