local lualine = require('lualine')

local colors = {
    black        = '#121212',
    white        = '#FFFFFF',
    red          = '#FF473B',
    green        = '#50FF7F',
    blue         = '#3F4EF9',
    purple       = '#AF86F3',
    yellow       = '#FFD094',
    gray         = '#777989',
    darkgray     = '#777989',
    lightgray    = '#E1E1E1',
    inactivegray = '#777989',
}

return lualine.setup {
    options = {
        theme = {
            inactive = {
                a = { bg = colors.darkgray, fg = colors.black, gui = 'bold' },
                b = { bg = colors.black, fg = colors.lightgray },
                c = { bg = colors.black, fg = colors.lightgray }
            },
            normal = {
                a = { bg = colors.darkgray, fg = colors.black, gui = 'bold' },
                b = { bg = colors.black, fg = colors.lightgray },
                c = { bg = colors.black, fg = colors.lightgray }
            },
            insert = {
                a = { bg = colors.green, fg = colors.black, gui = 'bold' },
                b = { bg = colors.black, fg = colors.lightgray },
                c = { bg = colors.black, fg = colors.lightgray }
            },
            visual = {
                a = { bg = colors.purple, fg = colors.black, gui = 'bold' },
                b = { bg = colors.black, fg = colors.lightgray },
                c = { bg = colors.black, fg = colors.lightgray }
            },
            replace = {
                a = { bg = colors.yellow, fg = colors.black, gui = 'bold' },
                b = { bg = colors.black, fg = colors.lightgray },
                c = { bg = colors.black, fg = colors.lightgray }
            },
            command = {
                a = { bg = colors.white, fg = colors.black, gui = 'bold' },
                b = { bg = colors.black, fg = colors.lightgray },
                c = { bg = colors.black, fg = colors.lightgray }
            }
        }
    }
}
