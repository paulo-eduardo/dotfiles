return {
  "nvim-telescope/telescope.nvim",
  opts = {
    defaults = {
      -- Don't use git as the default root
      respect_gitignore = true,
      -- Use the current directory instead of trying to find a git root
      find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
      -- Ignore node_modules and other directories you don't want to search
      file_ignore_patterns = {
        "node_modules",
        ".git/",
        ".cache",
        "%.o",
        "%.a",
        "%.out",
        "%.class",
        "%.pdf",
        "%.mkv",
        "%.mp4",
        "%.zip",
        -- Add patterns to ignore api directory if you're in app directory
        -- These will be applied conditionally in the setup function
      },
      -- Other default settings
      path_display = { "truncate" },
      sorting_strategy = "ascending",
      layout_config = {
        horizontal = {
          prompt_position = "top",
        },
      },
    },
    pickers = {
      find_files = {
        -- Don't use git as the root finder
        find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
        hidden = false,
        follow = true,
      },
      live_grep = {
        -- Also set the grep to not use git root
        grep_open_files = false,
      },
      buffers = {
        show_all_buffers = false,
      },
    },
  },
  config = function(_, opts)
    -- Get the current working directory
    local cwd = vim.fn.getcwd()

    -- Check if we're in the app directory
    if string.match(cwd, "/app$") then
      -- If in app directory, add api to ignore patterns
      table.insert(opts.defaults.file_ignore_patterns, "^api/")
    elseif string.match(cwd, "/api$") then
      -- If in api directory, add app to ignore patterns
      table.insert(opts.defaults.file_ignore_patterns, "^app/")
    end

    -- Setup telescope with our options
    require("telescope").setup(opts)

    -- Add custom keymaps that explicitly use the current directory
    vim.keymap.set("n", "<leader>ff", function()
      require("telescope.builtin").find_files({
        cwd = vim.fn.getcwd(),
        hidden = false,
        no_ignore = false,
      })
    end, { desc = "Find Files (Current Dir)" })

    vim.keymap.set("n", "<leader>fg", function()
      require("telescope.builtin").live_grep({
        cwd = vim.fn.getcwd(),
      })
    end, { desc = "Live Grep (Current Dir)" })
  end,
}
