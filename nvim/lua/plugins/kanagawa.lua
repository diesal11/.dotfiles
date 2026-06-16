return {
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function(plugin, opts)
            vim.opt.background = "dark"
            --     require(plugin.name).setup(opts)
            vim.cmd.colorscheme("kanagawa")
        end,
    },
}
