local config = require("winbar.config")

local M = {}

function M.setup(opts)
  config.set_options(opts)
  local winbar = require("winbar.winbar")
  vim.api.nvim_create_autocmd(
    { "DirChanged", "CursorMoved", "BufWinEnter", "BufFilePost", "InsertEnter", "BufWritePost" },
    {
      callback = function()
        winbar.show_winbar()
      end,
    }
  )
end

return M
