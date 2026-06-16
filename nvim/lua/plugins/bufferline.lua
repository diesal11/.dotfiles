return {
    {
        "akinsho/bufferline.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = function()
            return {
                options = {
                    separator_style = "slant",
                    diagnostics = "nvim_lsp",
                    offsets = {
                        {
                            filetype = "NvimTree",
                            text = "File Explorer",
                            text_align = "center",
                            separator = true,
                        },
                    },
                },
            }
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = function()
            return {
                options = {
                    icons_enabled = true,
                    globalstatus = true,
                },
            }
        end,
    },
    { "AndreM222/copilot-lualine" },
}
