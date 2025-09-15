return {
    "nvim-tree/nvim-tree.lua", -- Explorador de archivos
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("nvim-tree").setup()
        vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
	    vim.keymap.set("n", "<leader>f", ":NvimTreeFindFile<CR>")
    end,
}
