return {
    "weirongxu/plantuml-previewer.vim",
    config = function()
        require("plantuml-previewer").setup({
            preview_command = "open -a /Applications/PlantUML.app",
            open_cmd = "open -a /Applications/PlantUML.app",
            plantuml_args = {
                "-tsvg",
                "-pipe",
                "-charset",
                "utf-8",
            },
        })
    end,
}
