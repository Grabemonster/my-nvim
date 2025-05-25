return { 
    {
        "brianhuster/live-preview.nvim",
    },
    --{
    --    'https://gitlab.com/itaranto/preview.nvim',
    --    version = '*',
    --    opts = {
    --        render_on_write = true,
    --        previewers_by_ft = {
    --            plantuml = {
    --                name = 'plantuml_svg',
    --                renderer = {
    --                    type = 'imv',
    --                },
    --            },
    --        },
    --    }
    --} 
    {
        dir = vim.fn.stdpath("config") .. "/lua/customPlugins/plantumlWatch",
        ft = { "plantuml" },
        config = function()
            require("customPlugins.plantumlWatch").setup({
                args = { "-tsvg", "-darkmode" },
                on_rendered = function(output_file)
                    vim.notify(output_file, vim.log.levels.INFO)
                end,
            })
        end,
    },
}
