return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")

      telescope.setup({
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      })
      telescope.load_extension("fzf")

      -- Keymaps
      vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "Find files" })
      vim.keymap.set("n", "<leader>sh", function() builtin.find_files({ hidden = true }) end, { desc = "Find hidden files" })
      vim.keymap.set("n", "<leader>sH", builtin.help_tags, { desc = "Help tags" })
      vim.keymap.set("n", "<leader>sg", function() builtin.live_grep({ hidden = true }) end, { desc = "Live grep hidden" })
      vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "Buffers" })
      vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "Diagnostics" })
    end,
  },
}

