return {
  "norcalli/nvim-colorizer.lua",
  config = function()
    require("colorizer").setup({
      '*'; -- Activar para todos los archivos
    }, {
      mode = 'background'; -- o 'foreground' o 'virtualtext'
      names = false; -- No mostrar nombres de colores
    })
  end,
}
