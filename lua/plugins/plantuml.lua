return { 
    {
        "brianhuster/live-preview.nvim",
    },
    {
        'https://gitlab.com/itaranto/preview.nvim',
        version = '*',
        opts = {
            render_on_write = true,
            previewers_by_ft = {
                plantuml = {
                    name = 'plantuml_svg',
                    renderer = {
                        type = 'command',
                        opts = { 
                            cmd = { 'sh', '-c', 'gio open "$1"', '_' }
                        }, -- oder 'chromium', 'xdg-open'
                    },
                },
            },
        }
    }
}
