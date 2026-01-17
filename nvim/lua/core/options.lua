-- ~/.config/nvim/lua/core/options.lua

local opt = vim.opt

-- --- Configuración de Interfaz ---
opt.number = true           -- Muestra números de línea
opt.relativenumber = true   -- Números relativos (ideal para saltos rápidos)
opt.mouse = "a"             -- Habilitar ratón en todos los modos
opt.termguicolors = true    -- Colores reales de 24 bits
opt.cursorline = true       -- Resalta la línea actual
opt.signcolumn = "yes"      -- Columna fija para iconos de LSP/Git

-- --- Tabulación y Sangría (PEP 8 para Python) ---
opt.expandtab = true        -- Convierte tabs en espacios
opt.shiftwidth = 4          -- Tamaño de la sangría
opt.tabstop = 4             -- Un tab visualmente vale 4 espacios
opt.softtabstop = 4         -- Espacios al presionar tab
opt.smartindent = true      -- Sangría inteligente automática

-- --- Comportamiento del Editor ---
opt.ignorecase = true       -- Ignora mayúsculas al buscar...
opt.smartcase = true        -- ...a menos que se escriba una mayúscula
opt.splitbelow = true       -- Splits horizontales se abren abajo
opt.splitright = true       -- Splits verticales se abren a la derecha
opt.clipboard = "unnamedplus" -- Usa el portapapeles del sistema (requiere xclip o wl-copy)
opt.scrolloff = 8           -- Mantiene 8 líneas visibles arriba/abajo al hacer scroll
opt.updatetime = 250        -- Tiempo de respuesta más rápido para plugins

-- --- Tecla Líder ---
vim.g.mapleader = " "       -- Espacio como tecla líder (muy común en Neovim)
