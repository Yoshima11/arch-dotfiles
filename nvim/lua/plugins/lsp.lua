-- ~/.config/nvim/lua/plugins/lsp.lua
return {
  "neovim/nvim-lspconfig",
  config = function()
    -- Habilitar Pyright para inteligencia de tipos
    vim.lsp.enable('pyright')

    -- Habilitar Ruff para Linting y correcciones
    vim.lsp.enable('ruff')

    -- Configuración específica al conectar un LSP
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        -- local opts = { buffer = args.buf }
        local bufnr = args.buf

        -- Si el cliente es Ruff, podemos desactivar su capacidad de hover
        -- para que Pyright se encargue de las descripciones de tipos
        if client.name == 'ruff' then
          client.server_capabilities.hoverProvider = false
        end

        -- Atajos útiles
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, 
        { buffer = bufnr, desc = "LSP: [G]oto [D]efinition" })

        vim.keymap.set('n', 'K', vim.lsp.buf.hover, 
        { buffer = bufnr, desc = "LSP: Hover Documentation" })

        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, 
        { buffer = bufnr, desc = "LSP: [C]ode [A]ction" })

        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, 
        { buffer = bufnr, desc = "LSP: [R]e[n]ame" })
      end,
    })
  end,
}
