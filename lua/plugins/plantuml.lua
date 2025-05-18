return {
    {
        "weirongxu/plantuml-previewer.vim",
        dependencies = { "tyru/open-browser.vim" },
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
        config = function()
            vim.g.mkdp_auto_start = 1
            vim.g.mkdp_auto_close = 1
            vim.g.mkdp_refresh_slow = 0
            vim.g.mkdp_command_for_global = 0
            vim.g.mkdp_open_to_the_world = 0
            vim.g.mkdp_open_ip = ''
            vim.g.mkdp_browser = 'firefox'
            vim.g.mkdp_echo_preview_url = 1
            vim.g.mkdp_browserfunc = ''
        end,
    }

}
