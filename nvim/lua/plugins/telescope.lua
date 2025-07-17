return {
  "nvim-telescope/telescope.nvim",
  keys = {
    { "<leader>sx", require("telescope.builtin").resume, noremap = true, silent = true, desc = "Resume Telescope" },
  },
}
