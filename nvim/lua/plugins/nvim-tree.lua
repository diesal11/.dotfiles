return {
    {
        "kyazdani42/nvim-tree.lua",
        keys = {
            {
                "<leader>fl",
                function()
                    require("nvim-tree.api").tree.open({
                        focus = true,
                        find_file = true,
                    })
                end,
                desc = "Locate file in explorer",
            },
            {
                "h",
                "<cmd>NvimTreeToggle<CR>",
                desc = "Toggle file explorer",
            },
            {
                "H",
                function()
                    local api = require("nvim-tree.api")
                    api.tree.collapse_all()
                end,
                desc = "Collapse All",
            },
            {
                "l",
                function()
                    local api = require("nvim-tree.api")
                    local node = api.tree.get_node_under_cursor()

                    if node.nodes ~= nil then
                        -- expand or collapse folder
                        api.node.open.edit()
                    else
                        -- open file
                        api.node.open.edit()
                        -- Close the tree if file was opened
                        api.tree.close()
                    end
                end,
                desc = "Edit Or Open",
            },
            {
                "L",
                function()
                    local node = api.tree.get_node_under_cursor()

                    if node.nodes ~= nil then
                        -- expand or collapse folder
                        api.node.open.edit()
                    else
                        -- open file as vsplit
                        api.node.open.vertical()
                    end

                    -- Finally refocus on tree if it was lost
                    api.tree.focus()
                end,
                desc = "Vsplit Preview",
            },
            {
                "t",
                function()
                    local node = api.tree.get_node_under_cursor()
                    node.open.tab(node)
                    vim.cmd.tabprev()
                end,
                desc = "Open Tab Silent",
            },
        },
        opts = function()
            local icons = require("user.icons")
            return {
                hijack_netrw = false,
                diagnostics = {
                    enable = true,
                    icons = icons.nerdtree,
                },
                respect_buf_cwd = true,
                on_attach = function(bufnr)
                    local api = require("nvim-tree.api")

                    local function opts(desc)
                        return {
                            desc = "nvim-tree: " .. desc,
                            buffer = bufnr,
                            noremap = true,
                            silent = true,
                            nowait = true,
                        }
                    end

                    api.config.mappings.default_on_attach(bufnr)

                    vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
                    vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
                    vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
                    vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts("Open"))
                    vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
                end,
                renderer = {
                    add_trailing = true,
                    highlight_git = true,
                    indent_markers = {
                        enable = true,
                    },
                    special_files = { "Makefile", "README.md", "go.mod" },
                    icons = {
                        glyphs = {
                            git = {
                                unstaged = icons.ui.exclamation,
                                staged = icons.ui.plus,
                                unmerged = icons.git.merge,
                                renamed = icons.ui.arrow_right,
                                untracked = icons.ui.question,
                                deleted = icons.ui.minus,
                                ignored = icons.ui.times,
                            },
                        },
                    },
                },
                git = {
                    ignore = false,
                },
                view = {
                    adaptive_size = true,
                    width = 40,
                    side = "left",
                },
                actions = {
                    file_popup = {
                        open_win_config = {
                            border = "rounded",
                        },
                    },
                    open_file = {
                        window_picker = {
                            enable = false,
                        },
                    },
                },
            }
        end,
        config = function(_, opts)
            -- Open file on creation
            vim.api.nvim_create_autocmd("BufWritePost", {
                pattern = "*",
                callback = function(args)
                    if vim.fn.filereadable(args.file) == 1 then
                        vim.cmd("edit " .. args.file)
                    end
                end,
            })

            -- Make :bd and :q behave as usual when tree is visible
            vim.api.nvim_create_autocmd({ "BufEnter", "QuitPre" }, {
                nested = false,
                callback = function(e)
                    local tree = require("nvim-tree.api").tree

                    -- Nothing to do if tree is not opened
                    if not tree.is_visible() then
                        return
                    end

                    -- How many focusable windows do we have? (excluding e.g. incline status window)
                    local winCount = 0
                    for _, winId in ipairs(vim.api.nvim_list_wins()) do
                        if vim.api.nvim_win_get_config(winId).focusable then
                            winCount = winCount + 1
                        end
                    end

                    -- We want to quit and only one window besides tree is left
                    if e.event == "QuitPre" and winCount == 2 then
                        vim.api.nvim_cmd({
                            cmd = "qall",
                        }, {})
                    end

                    -- :bd was probably issued an only tree window is left
                    -- Behave as if tree was closed (see `:h :bd`)
                    if e.event == "BufEnter" and winCount == 1 then
                        -- Required to avoid "Vim:E444: Cannot close last window"
                        vim.defer_fn(function()
                            -- close nvim-tree: will go to the last buffer used before closing
                            tree.toggle({
                                find_file = true,
                                focus = true,
                            })
                            -- re-open nivm-tree
                            tree.toggle({
                                find_file = true,
                                focus = false,
                            })
                        end, 10)
                    end
                end,
            })

            local function open_nvim_tree(data)
                -- buffer is a real file on the disk
                local real_file = vim.fn.filereadable(data.file) == 1

                -- buffer is a [No Name]
                local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

                -- buffer is a directory
                local directory = vim.fn.isdirectory(data.file) == 1

                if directory then
                    -- create a new, empty buffer
                    vim.cmd.enew()

                    -- wipe the directory buffer
                    vim.cmd.bw(data.buf)

                    -- change to the directory
                    vim.cmd.cd(data.file)

                    -- open the tree
                    require("nvim-tree.api").tree.toggle({
                        focus = false,
                    })

                    vim.cmd("Dashboard")
                end

                if real_file then
                    -- Change to the directory of the file
                    vim.cmd.cd(vim.fn.fnamemodify(data.file, ":h"))

                    -- open the tree
                    require("nvim-tree.api").tree.toggle({
                        find_file = true,
                        focus = true,
                    })
                end
            end
            vim.api.nvim_create_autocmd({ "VimEnter" }, {
                callback = open_nvim_tree,
            })

            -- Setup nvim-tree.api
            require("nvim-tree").setup(opts)
        end,
    },
}
