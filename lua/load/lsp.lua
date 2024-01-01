local mason = require("mason")
local masonLspconfig = require("mason-lspconfig")
local lsp_zero = require('lsp-zero')
local cmp = require('cmp')
local cmp_action = lsp_zero.cmp_action()
local languages = { 'tsserver', 'eslint', 'lua_ls', 'bashls', 'gopls', 'taplo', 'jsonls' }

lsp_zero.on_attach(function(_, bufnr)
    lsp_zero.default_keymaps({ buffer = bufnr })
end)

mason.setup(languages)

masonLspconfig.setup({
    ensure_installed = languages,
    handlers = {
        lsp_zero.default_setup,
        lua_ls = function()
            require('lspconfig').lua_ls.setup({
                settings = { Lua = { diagnostics = { globals = { 'vim' } } } }
            })
        end,
    }
})

cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
    })
})
