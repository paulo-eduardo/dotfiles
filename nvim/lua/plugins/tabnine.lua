return {
  "codota/tabnine-nvim",
  build = "./dl_binaries.sh",
  event = "VeryLazy",
  config = function()
    require("tabnine").setup({
      disable_auto_comment = true,
      dismiss_keymap = "<C-]>",
      debounce_ms = 800,
      suggestion_color = { gui = "#808080", cterm = 244 },
      exclude_filetypes = { "TelescopePrompt", "NvimTree" },
      log_file_path = nil, -- absolute path to TabNine log file
      disable_suggestions = true, -- disable autocompletion suggestions
    })
  end,
}
