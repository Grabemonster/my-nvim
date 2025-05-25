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
                        opts = { cmd = { 'firefox' } }, -- oder 'chromium', 'xdg-open'
                    },
                },
            },
            previewers = {
                plantuml_svg = {
                    -- args für SVG-Ausgabe, stdin=false bedeutet Datei-Input
                    command = 'plantuml',
                    args = { '-tsvg', '$INPUT_FILE', '-o', '.' },
                    stdin = false,
                    stdout = false,
                },
            },
        }
    }

    --{
    --    "iamcco/markdown-preview.nvim",
    --    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    --    build = function()
    --        vim.fn["mkdp#util#install"]()
    --    end,
    --    config = function()
    --        vim.g.mkdp_auto_start = 0
    --        vim.g.mkdp_auto_close = 1
    --        vim.g.mkdp_refresh_slow = 0
    --        vim.g.mkdp_command_for_global = 0
    --        vim.g.mkdp_open_to_the_world = 0
    --        vim.g.mkdp_browser = 'firefox'
    --        vim.g.mkdp_echo_preview_url = 1
    --        vim.g.mkdp_browserfunc = ''
    --    end,
    --}
}
