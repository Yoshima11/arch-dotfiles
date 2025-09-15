return {
        "nvim-lualine/lualine.nvim", -- Barra de estado
        config = function()
            require("lualine").setup ({
	    	options = {
                    icons_enabled = true, -- Habilita iconos
                    theme = "onedark",       -- Tema automático basado en tu colorscheme
                    component_separators = { left = "", right = "" },
                    section_separators = { left = "", right = "" },
                    disabled_filetypes = {}, -- Deshabilitar en ciertos tipos de archivos
                    always_divide_middle = true,
                },
                sections = {
                    lualine_a = { "mode" }, -- Modo actual (Normal, Insert, Visual, etc.)
                    lualine_b = { "branch", "diff", "diagnostics" }, -- Rama de Git, cambios, errores
                    lualine_c = { "filename" }, -- Nombre del archivo
                    lualine_x = { "encoding", "fileformat", "filetype" }, -- Codificación, formato, tipo de archivo
                    lualine_y = { "progress" }, -- Progreso en el archivo
                    lualine_z = { "location" }, -- Número de línea/columna
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { "filename" },
                    lualine_x = { "location" },
                    lualine_y = {},
                    lualine_z = {},
                },
                tabline = {}, -- Opcional: configuración para pestañas
                extensions = {} -- Extensiones adicionales
            })
        end,
}
