return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      filtered_items = {
        visible = true, -- When true, they will just be displayed differently than normal items
        hide_dotfiles = false,
        hide_gitignored = false,
      },
      -- Add these settings to respect the current working directory
      follow_current_file = {
        enabled = true,
      },
      use_libuv_file_watcher = true,
      -- This will use the current working directory as the root
      -- instead of trying to find a git root or other project root
      never_show_by_pattern = {
        -- Hide node_modules directory
        "node_modules",
      },
      -- Add this to always use the current working directory
      bind_to_cwd = true,
      -- This ensures Neo-tree doesn't change Neovim's CWD
      cwd_target = {
        sidebar = "global",
        current = "global",
      },
    },
    window = {
      mappings = {
        ["<space>"] = "none", -- Unbind space to avoid conflicts
      },
    },
    -- Set this to true to start Neo-tree with the cwd as the root
    cwd_target = {
      sidebar = "cwd",
      current = "cwd",
    },
    event_handlers = {
      {
        event = "neo_tree_buffer_enter",
        handler = function()
          -- Set the cwd to the initial directory when entering Neo-tree buffer
          vim.cmd("cd " .. vim.fn.getcwd())
        end,
      },
    },
  },
  config = function(_, opts)
    -- Store the initial working directory
    local initial_cwd = vim.fn.getcwd()

    -- Modify the opts to use the initial_cwd
    opts.filesystem.cwd_target = {
      sidebar = initial_cwd,
      current = initial_cwd,
    }

    require("neo-tree").setup(opts)
  end,
}
