local opt = vim.opt

-- Configuración específica para Python
vim.api.nvim_create_autocmd('FileType', {
  -- pattern = 'python',
  callback = function()
    opt_local = vim.opt_local
    opt_local.shiftwidth = 4
    opt_local.tabstop = 4
    opt_local.softtabstop = 4
    opt_local.expandtab = true
    opt_local.smartindent = true
    opt_local.textwidth = 120
    opt_local.colorcolumn = '120'
    opt_local.foldmethod = 'indent'
  end
})

-- Configuración general
opt.mouse = 'a'
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.signcolumn = 'yes'
opt.updatetime = 300
opt.timeoutlen = 500
opt.clipboard = 'unnamedplus'
opt.completeopt = 'menuone,noselect'
