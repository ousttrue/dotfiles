local M = {}

function M.setup()
    require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        mode = "document_diagnostics",
        auto_open = true,
        signs = {
            -- icons / text used for a diagnostic
            error = "",
            warning = "",
            hint = "",
            information = "",
            other = "﫠",
        },
        use_diagnostic_signs = true,
    }
end

return M
