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
  "plantuml-autowatch",
  ft = { "puml", "plantuml" },
  config = function()
    -- Konfigurierbare Optionen
    local plantuml_args = { "-tsvg", "-darkmode" }

    -- OPTIONAL: Hier definierst du, was passieren soll, wenn Rendering abgeschlossen ist
    local function on_rendered(output_file)
    end

    -- Hilfsfunktion zum Ermitteln der erwarteten Ausgabedatei (basierend auf -tXXX)
    local function get_output_file(input_file)
      local ext = "png" -- Default
      for _, arg in ipairs(plantuml_args) do
        if arg == "-tsvg" then ext = "svg" end
        if arg == "-tpng" then ext = "png" end
        if arg == "-teps" then ext = "eps" end
        if arg == "-tpdf" then ext = "pdf" end
        if arg == "-latex" then ext = "tex" end
      end
      return input_file:gsub("%.pu?ml$", "." .. ext)
    end

    vim.api.nvim_create_autocmd("BufWritePost", {
      pattern = { "*.puml", "*.plantuml" },
      callback = function(args)
        local file = args.file
        local cmd = { "plantuml" }
        vim.list_extend(cmd, plantuml_args)
        table.insert(cmd, file)

        local output_file = get_output_file(file)

        vim.fn.jobstart(cmd, {
          stdout_buffered = true,
          stderr_buffered = true,
          on_stdout = function(_, data)
            if data then print(table.concat(data, "\n")) end
          end,
          on_stderr = function(_, data)
            if data then vim.notify(table.concat(data, "\n"), vim.log.levels.ERROR) end
          end,
          on_exit = function()
            on_rendered(output_file)
          end,
        })
      end,
    })
  end,
} end,
    }
}
