-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Ctrl + Alt + N to run current file based on extension
local Terminal = require("toggleterm.terminal").Terminal

-- table to store toggleable terminals
local terminals = {}

function RunCurrentFile()
  local ft = vim.bo.filetype
  local file = vim.fn.expand("%")
  local cmd

  if ft == "python" then
    cmd = "python3 " .. file
  elseif ft == "javascript" then
    cmd = "node " .. file
  elseif ft == "cpp" then
    local output = vim.fn.expand("%:r")
    cmd = "g++ " .. file .. " -o " .. output .. " && ./" .. output
  else
    print("Filetype not supported")
    return
  end

  -- create terminal if it doesn't exist yet
  if not terminals[ft] then
    terminals[ft] = Terminal:new({
      cmd = cmd,
      hidden = true, -- start hidden
      direction = "horizontal", -- can also be "float"
      close_on_exit = false, -- keep terminal open after running
    })
  else
    -- update command by recreating the terminal
    terminals[ft] = Terminal:new({
      cmd = cmd,
      hidden = true,
      direction = "horizontal",
      close_on_exit = false,
    })
  end

  -- toggle terminal open/closed
  terminals[ft]:toggle()
end

-- keybinding: Ctrl + Alt + N
vim.api.nvim_set_keymap("n", "<C-A-n>", ":w<CR>:lua RunCurrentFile()<CR>", { noremap = true, silent = true })
