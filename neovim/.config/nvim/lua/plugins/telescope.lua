return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("telescope").setup({
      defaults = {
        file_ignore_patterns = { "%.git/" }, -- Optionally exclude `.git` directory
        find_command = { "fd", "--type", "file", "--hidden", "--follow" }, -- For hidden files
      },
      pickers = {
        find_files = {
          hidden = true, -- Include hidden files in the `find_files` picker
        },
      },
    })
    vim.api.nvim_set_keymap("n", "<leader>ff", ":Telescope find_files<CR>", { noremap = true, silent = true })
    vim.keymap.set("n", "<leader><leader>", function()
      require("telescope.builtin").find_files({ hidden = true })
    end, { desc = "Find all files (hidden included)" })
  end,
}
