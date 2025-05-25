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
        'javiorfo/nvim-soil',

        -- Optional for puml syntax highlighting:
        dependencies = { 'javiorfo/nvim-nyctophilia' },

        lazy = true,
        ft = "plantuml",
        opts = {
            -- If you want to change default configurations

            -- This option closes the image viewer and reopen the image generated
            -- When true this offers some kind of online updating (like plantuml web server)
            actions = {
                redraw = true
            },
            -- If you want to customize the image showed when running this plugin
            image = {
                darkmode = false, -- Enable or disable darkmode
                format = "svg", -- Choose between png or svg 

                execute_to_open = function(img)
                    return
                end
            }
        }
    }
}
