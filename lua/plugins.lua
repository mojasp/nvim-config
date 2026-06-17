-- Bootstrap lazy.nvim to:
--    lazy-nvim release 11.17.5 from Thu Nov 6 10:26:21 2025 +0100
-- (for future reference, the repo is located in ~/.local/share/nvim/lazy/lazy.nvim)
local lazy_commit = "85c7ff3711b730b4030d03144f6db6375044ae82"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        lazyrepo,
        lazypath,
    })

    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end

    vim.fn.system({
        "git",
        "-C",
        lazypath,
        "checkout",
        lazy_commit,
    })
end

vim.opt.rtp:prepend(lazypath)

local pins = require("plugin_pins")

local function pin(repo, spec)
    spec = spec or {}
    spec[1] = repo

    local p = pins[repo]
    if not p then
        error("Missing plugin pin for " .. repo .. ". Run tools/update-plugin-pins.py")
    end

    spec.pin = true
    spec.commit = p.commit

    -- Only set tag when the repo actually has a usable tag/release.
    if p.tag then
        spec.tag = p.tag
    end

    return spec
end

require("lazy").setup({
    spec = {
        -- nvimlsp plugins
        pin("mason-org/mason.nvim"),
        pin("mason-org/mason-lspconfig.nvim", {
            dependencies = {
                "mason-org/mason.nvim",
                "neovim/nvim-lspconfig",
            },
        }),
        pin("neovim/nvim-lspconfig"),
        pin("nvimtools/none-ls.nvim"),
        pin("SmiteshP/nvim-navic", {
            config = function()
                require("nvim-navic").setup()
            end,
        }),

        --  autocomplete plugins
        pin("hrsh7th/nvim-cmp"),
        pin("hrsh7th/cmp-omni"),
        pin("hrsh7th/cmp-nvim-lsp"),
        pin("hrsh7th/cmp-buffer"),
        pin("hrsh7th/cmp-path"),
        pin("hrsh7th/cmp-cmdline"),
        pin("onsails/lspkind-nvim"),
        pin("saadparwaiz1/cmp_luasnip", {
            dependencies = {
                "hrsh7th/nvim-cmp",
                "L3MON4D3/LuaSnip",
            },
        }),
        pin("L3MON4D3/LuaSnip", {
            build = "make install_jsregexp",
        }),
        pin("honza/vim-snippets"),

        -- treesitter plugins
        pin("nvim-treesitter/nvim-treesitter", {
            build = ":TSUpdate",
        }),
        --    use("nvim-treesitter/nvim-treesitter-context") -- redundant with navic
        pin("danymat/neogen"),

        pin("hedyhli/outline.nvim", {
            config = function()
                require("outline").setup({})
            end,
        }),

        -- colorscheme
        pin('NLKNguyen/papercolor-theme'),
        pin("rebelot/kanagawa.nvim"),
        pin("iruzo/matrix-nvim"),
        pin("catppuccin/nvim", {
            name = "catppuccin",
        }),

        pin('glench/vim-jinja2-syntax'),

        -- fzf - this is only used for vimtex integration
        pin("junegunn/fzf", {
            build = function()
                vim.cmd([[call fzf#install()]])
            end,
        }),

        -- telescope
        pin("nvim-lua/plenary.nvim"), -- Useful lua functions used ny lots of plugins
        pin("nvim-telescope/telescope.nvim", {
            branch = "0.1.x",
            dependencies = {
                "nvim-lua/plenary.nvim",
            },
        }),
        pin("nvim-telescope/telescope-file-browser.nvim", {
            dependencies = {
                "nvim-telescope/telescope.nvim",
            },
        }),
        -- use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
        pin('nvim-telescope/telescope-fzf-native.nvim', {
            build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release',
            dependencies = {
                "nvim-telescope/telescope.nvim",
            },
        }),
        pin("nvim-telescope/telescope-ui-select.nvim", {
            dependencies = {
                "nvim-telescope/telescope.nvim",
            },
        }),
        pin("benfowler/telescope-luasnip.nvim", {
            dependencies = {
                "nvim-telescope/telescope.nvim",
                "L3MON4D3/LuaSnip",
            },
        }),

        pin("nvim-telescope/telescope-bibtex.nvim", {
            dependencies = {
                "nvim-telescope/telescope.nvim",
            },
            config = function()
                require("telescope").load_extension("bibtex")
            end,
        }),

        ------------------------------------
        ----------Utilities-----------------
        ------------------------------------
        ------- Coding utils -------
        pin("tpope/vim-dispatch"),

        --- Language specific
        pin("vim-scripts/a.vim"), -- switch from .h to .c via :A

        -- R language support
        pin("jalvesaq/Nvim-R", {
            config = function()
                -- vim.cmd("let R_external_term = 1")
            end,
        }),

        --vimiwiki & taskwarrior
        pin("vimwiki/vimwiki", {
            init = function()
                vim.g.vimwiki_key_mappings = {
                    all_maps = 0,   -- all the mappings so broken ffs
                }
            end,
        }),
        pin("tools-life/taskwiki", {
            dependencies = {
                "vimwiki/vimwiki",
            },
        }), --taskwarrior support for vimwiki

        --disable - lag?
        --use({
        --     "gaoDean/autolist.nvim",
        --     tag = "*",
        --     config = function()
        --         require("autolist").setup({})
        --     end,
        --})

        --vimtex important
        pin("lervag/vimtex"),

        ----- MISC -----
        ---better quickfix; including preview and fzf support (press zf in qf win)
        -- use({ "kevinhwang91/nvim-bqf", ft = "qf" })

        -- use("tpope/vim-vinegar") -- navigation with -
        -- try oil istead
        pin("stevearc/oil.nvim", {
            config = function()
                require("oil").setup({
                    use_default_keymaps = false,
                    -- These are the default keymaps, commented out only what i want
                    keymaps = {
                        ["g?"] = { "actions.show_help", mode = "n" },
                        ["<CR>"] = "actions.select",
                        ["<C-v>"] = { "actions.select", opts = { vertical = true } },
                        ["<C-x>"] = { "actions.select", opts = { horizontal = true } },
                        ["<C-p>"] = "actions.preview",
                        ["<C-q>"] = { "actions.close", mode = "n" },
                        -- ["<C-l>"] = "actions.refresh",
                        ["-"] = { "actions.parent", mode = "n" },
                        ["_"] = { "actions.open_cwd", mode = "n" },
                        ["`"] = { "actions.cd", mode = "n" },
                        ["gs"] = { "actions.change_sort", mode = "n" },
                        ["gx"] = "actions.open_external",
                        ["g."] = { "actions.toggle_hidden", mode = "n" },
                    },
                })
                vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
            end,
        }),

        -----Git------
        pin("lewis6991/gitsigns.nvim", {
            dependencies = {
                "petertriho/nvim-scrollbar",
            },
            config = function()
                require("gitsigns").setup()
                require("scrollbar.handlers.gitsigns").setup()
            end,
        }),

        --general git
        pin("tpope/vim-fugitive"),

        -- depends on fugitive. :Flog gives git history
        pin("rbong/vim-flog", {
            dependencies = {
                "tpope/vim-fugitive",
            },
        }),

        pin("sindrets/diffview.nvim", {
            dependencies = {
                "nvim-lua/plenary.nvim",
            },
            config = function()
                require("diffview").setup({
                    hooks = {
                        diff_buf_read = function(bufnr)
                            -- set nowrap in diffbuffer so the diff lines up
                            vim.opt_local.wrap = false
                        end,
                    },
                })
            end,
        }),

        pin("nvim-lualine/lualine.nvim", {
            dependencies = {
                "kyazdani42/nvim-web-devicons",
            },
        }),

        pin("aserowy/tmux.nvim"),

        -- will autoset directoryy
        pin("ahmedkhalf/project.nvim", {
            config = function()
                require("project_nvim").setup({
                    ignore_lsp = { "null-ls", "r-language-server" },
                    -- When set to false, you will get a message when project.nvim changes your
                    -- directory.
                    silent_chdir = true,
                    exclude_dirs = { "~" },
                })
            end,
        }),

        pin("windwp/nvim-autopairs"),
        pin("junegunn/vim-easy-align"),

        pin("kylechui/nvim-surround", {
            config = function()
                require("nvim-surround").setup({
                })
            end,
        }),

        -------------------------------
        ------User Interface-----------
        -------------------------------
        -- use({
        --     "nvim-zh/colorful-winsep.nvim",
        --     config = function()
        --         require("colorful-winsep").setup({
        --             highlight = {},
        --         })
        --     end,
        --})
        pin("kyazdani42/nvim-web-devicons", {
            config = function()
                require("nvim-web-devicons").setup()
            end,
        }),

        --visual guides for whitespaces, quite ncie
        pin("lukas-reineke/indent-blankline.nvim", {
            main = "ibl",
            opts = {},
        }),

        -- color picker and utilities
        pin("NvChad/nvim-colorizer.lua", {
            config = function()
                require("colorizer").setup()
            end,
        }),

        --rh scrollbar
        pin("petertriho/nvim-scrollbar", {
            config = function()
                require("scrollbar").setup()
            end,
        }),

        -- -------------------------------
        -- ------Debugger-----------------
        -- -------------------------------
        -- use("mfussenegger/nvim-dap")
        -- use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
        -- use({
        --     "theHamsta/nvim-dap-virtual-text",
        --     config = function()
        --         require("nvim-dap-virtual-text").setup()
        --     end,
        -- })
    },

    defaults = {
        lazy = false,
        version = false,
    },

    lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json",

    install = {
        missing = false,
        colorscheme = { "habamax" },
    },
    checker = {
        enabled = false,
        notify = false,
    },
    local_spec = false,

    rocks = {
        enabled = false,
    },

    ui = {
        border = "rounded",
    },
})
