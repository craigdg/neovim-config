local file = require('panes.source.file')
local diagnostic = require('panes.source.diagnostic')
local root = require('panes.source.root')
local empty = require('panes.source.empty')
local tree = require('panes.source.tree')
local lazygit = require('panes.source.lazygit')
local btop = require('panes.source.btop')
local floatingTerminal = require('panes.source.floatingTerminal')
local chatgpt = require('panes.source.chatgpt')

return {
    file = file,
    diagnostic = diagnostic,
    root = root,
    empty = empty,
    tree = tree,
    lazygit = lazygit,
    btop = btop,
    floatingTerminal = floatingTerminal,
    chatgpt = chatgpt
}
