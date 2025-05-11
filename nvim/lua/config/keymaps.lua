-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>sx", builtin.resume, { noremap = true, silent = true })

local opts = { noremap = true, silent = true }
-- Tabnine keybindings
vim.keymap.set("n", "<leader>ts", ":TabnineStatus<CR>", opts) -- Show status
vim.keymap.set("n", "<leader>tc", ":TabnineChat<CR>", opts) -- Open chat
vim.keymap.set("n", "<leader>ta", ":TabnineAccept<CR>", opts) -- Accept suggestion
vim.keymap.set("n", "<leader>tr", ":TabnineReject<CR>", opts) -- Reject suggestion
vim.keymap.set("n", "<leader>tf", ":TabnineFix<CR>", opts) -- Fix function in scope
vim.keymap.set("n", "<leader>tt", ":TabnineTest<CR>", opts) -- Generate tests
vim.keymap.set("n", "<leader>te", ":TabnineExplain<CR>", opts) -- Explain function

-- Flutter keybindings (using <leader>m for mobile)
-- Main commands
vim.keymap.set("n", "<leader>mr", ":FlutterRun<CR>", opts) -- Run the current project
vim.keymap.set("n", "<leader>md", ":FlutterDebug<CR>", opts) -- Force run in debug mode
vim.keymap.set("n", "<leader>mq", ":FlutterQuit<CR>", opts) -- End running session
vim.keymap.set("n", "<leader>mR", ":FlutterRestart<CR>", opts) -- Restart the current project
vim.keymap.set("n", "<leader>ml", ":FlutterReload<CR>", opts) -- Reload the running project

-- Device management
vim.keymap.set("n", "<leader>mD", ":FlutterDevices<CR>", opts) -- List connected devices
vim.keymap.set("n", "<leader>me", ":FlutterEmulators<CR>", opts) -- List emulators
vim.keymap.set("n", "<leader>ma", ":FlutterAttach<CR>", opts) -- Attach to running app
vim.keymap.set("n", "<leader>mdt", ":FlutterDetach<CR>", opts) -- Detach from running app

-- Tools and utilities
vim.keymap.set("n", "<leader>mo", ":FlutterOutlineToggle<CR>", opts) -- Toggle outline window
vim.keymap.set("n", "<leader>mO", ":FlutterOutlineOpen<CR>", opts) -- Open outline window
vim.keymap.set("n", "<leader>mT", ":FlutterDevTools<CR>", opts) -- Start Dart Dev Tools server
vim.keymap.set("n", "<leader>mA", ":FlutterDevToolsActivate<CR>", opts) -- Activate Dev Tools server
vim.keymap.set("n", "<leader>mp", ":FlutterCopyProfilerUrl<CR>", opts) -- Copy profiler URL

-- Development helpers
vim.keymap.set("n", "<leader>mL", ":FlutterLspRestart<CR>", opts) -- Restart Dart language server
vim.keymap.set("n", "<leader>ms", ":FlutterSuper<CR>", opts) -- Go to super class/method
vim.keymap.set("n", "<leader>mz", ":FlutterReanalyze<CR>", opts) -- Force LSP reanalyze
vim.keymap.set("n", "<leader>mn", ":FlutterRename<CR>", opts) -- Rename with import updates

-- Logs
vim.keymap.set("n", "<leader>mC", ":FlutterLogClear<CR>", opts) -- Clear log buffer
vim.keymap.set("n", "<leader>mt", ":FlutterLogToggle<CR>", opts) -- Toggle log buffer
