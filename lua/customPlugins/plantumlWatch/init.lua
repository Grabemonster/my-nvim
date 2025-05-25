local M = {}

function M.setup(opts)
    opts = opts or {}

    -- Default args, können durch opts.args überschrieben werden
    local plantuml_args = opts.args or { "-tsvg", "-darkmode" }

    -- Default on_rendered-Funktion, kann durch opts.on_rendered ersetzt werden
    local on_rendered = opts.on_rendered or function(output_file)
        vim.api.nvim_echo({{"Gerendert: " .. output_file, "Normal"}}, false, {})
        -- z.B. vim.fn.jobstart({ "xdg-open", output_file })
    end

    local function get_output_file(input_file)
        local ext = "png"
        for _, arg in ipairs(plantuml_args) do
            if arg == "-tsvg" then ext = "svg" end
            if arg == "-tpng" then ext = "png" end
            if arg == "-tpdf" then ext = "pdf" end
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
                    --if data then vim.notify(table.concat(data, "\n"), vim.log.levels.ERROR) end
                end,
                on_exit = function()
                    on_rendered(output_file)
                end,
            })
        end,
    })
end

return M
