local layouts = {
    default = 'default',
    terminal = 'terminal',
    git = 'git',
    find = 'find'
}

local initial = {
    terminal = {
        height = 18
    },
    layout = layouts.default,
}

local state = {
    terminals = {},
    terminal = {
        height = initial.terminal.height,
        lastSelected = nil
    },
    layout = initial.layout
}

return {
    layouts = layouts,
    initial = initial,
    state = state
}
