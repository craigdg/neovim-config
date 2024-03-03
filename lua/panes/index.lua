local file = require('panes.source.file')
local diagnostic = require('panes.source.diagnostic')
local terminal = require('panes.source.terminal')
local root = require('panes.source.root')
local empty = require('panes.source.empty')
local tree = require('panes.source.tree')
local lazygit = require('panes.source.lazygit')
local btop = require('panes.source.btop')
local floatingTerminal = require('panes.source.floatingTerminal')

return {
    file = file,
    diagnostic = diagnostic,
    terminal = terminal,
    root = root,
    empty = empty,
    tree = tree,
    lazygit = lazygit,
    btop = btop,
    floatingTerminal = floatingTerminal
}
