local telescope = require('telescope')

telescope.setup {
    defaults = {
        file_ignore_patterns = {
            "node_modules",
            "package-lock.json",
            "/package-lock.json",
            "/pnpm-lock.yaml",
        },
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '-uu',
            '--glob=!**/node_modules/**',
            '--glob=!**/package-lock.json',
            '--glob=!**/pnpm-lock.yaml',
        }
    }
}
