return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false, -- load immediately
    priority = 1000, -- load before other plugins
    config = function()
      require("kanagawa").setup({
        commentStyle = { italic = true },
        -- Optional: customize settings here
        -- See https://github.com/rebelot/kanagawa.nvim#configuration for full options
      })
      vim.cmd("colorscheme kanagawa")
      vim.cmd("highlight Normal guibg=#000000")
      vim.cmd("highlight EndOfBuffer guibg=#000000")
      vim.cmd("highlight LineNr guibg=#000000")
    end,
  },
}
