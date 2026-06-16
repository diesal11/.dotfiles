return {
    {
        "nvimdev/dashboard-nvim",
        event = "VimEnter",
        config = function(_, opts)
            require("dashboard").setup(opts)
        end,
        dependencies = { { "nvim-tree/nvim-web-devicons" } },
    },
    {
        "wellle/context.vim",
        config = function()
            vim.g.context_enabled = 1
        end,
    },
    {
        "folke/which-key.nvim",
        dependencies = { "echasnovski/mini.icons" },
        event = "VeryLazy",
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({
                        global = false,
                    })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    },
}
