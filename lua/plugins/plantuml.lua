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
        dir = vim.fn.stdpath("config") .. "/lua/customPlugins/plantumlWatch.lua",
        ft = { "puml", "plantuml" },
        opts = {
            args = { "-tsvg", "-darkmode" },
            on_rendered = function(output_file)
                print("Gerendert: " .. output_file)
            end,
        },
    }
}
