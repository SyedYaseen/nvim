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
    end,
  },
}
