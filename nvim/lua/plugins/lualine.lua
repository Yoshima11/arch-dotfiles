-- ~/.config/nvim/lua/plugins/lualine.lua
return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      theme = 'tokyonight',
      section_separators = '',
      component_separators = '',
    }
  }
}
