return {
  "norcalli/nvim-colorizer.lua",
  event = "VeryLazy",
  lazy = false,

  config = function()
    require("colorizer").setup({
      "*", -- Para todos los archivos
      css = { rgb_fn = true, hsl_fn = true, names = true },
      html = { names = false },
      lua = { names = false },
    }, {
      RGB = true,
      RRGGBB = true,
      RRGGBBAA = true,
      rgb_fn = true,
      hsl_fn = true,
      css_fn = true,
      names = true,
      mode = "background",
    })
    -- Activar inmediatamente después de cargar
    vim.schedule(function()
      require("colorizer").attach_to_buffer(0)  -- Buffer actual
    end)

    -- Activar en buffers actuales
    vim.defer_fn(function()
      for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(bufnr) then
          local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
          if ft == "" or ft == "lua" or ft == "css" then
            require("colorizer").attach_to_buffer(bufnr)
          end
        end
      end
    end, 100)
  end,
}
