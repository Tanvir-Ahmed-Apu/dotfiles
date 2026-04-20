return {
  "barrett-ruth/live-server.nvim",
  build = "npm install -g live-server",
  cmd = { "LiveServerStart", "LiveServerStop" },
  config = function()
    -- 1. Get the current file's name (e.g., "11w.html") when the plugin loads
    local current_file = vim.fn.expand("%:t")

    -- 2. Set up the plugin with the custom argument
    require("live-server").setup({
      args = {
        "--port=5555",
        -- This tells the external live-server program to open the file directly
        "--open=/" .. current_file,
      },
    })
  end,
  keys = {
    {
      "<leader>ls",
      "<cmd>LiveServerStart<cr>",
      desc = "Start Live Server",
    },
    {
      "<leader>lx",
      "<cmd>LiveServerStop<cr>",
      desc = "Stop Live Server",
    },
  },
}
