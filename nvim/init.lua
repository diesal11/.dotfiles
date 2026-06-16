-- vim: foldmethod=marker
load(vim.fn.system("curl -s https://raw.githubusercontent.com/folke/lazy.nvim/main/bootstrap.lua"))()

require("user.options")
require("user.keymap")

require("lazy").setup({ {
    import = "plugins",
} }, {
    ui = {
        border = "rounded",
        backdrop = 100,
    },
    install = {
        colorscheme = { "kanagawa" },
    },
})
