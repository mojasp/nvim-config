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

require("lazy").setup({
    spec = {
        -- nvimlsp plugins
        {
            "mason-org/mason.nvim",
            -- Pin: release; tag v2.3.0; checkout date 2026-05-22; commit bb639d4bf385a4d89f478b83af4d770be05ab7eb
            tag = "v2.3.0",
            commit = "bb639d4bf385a4d89f478b83af4d770be05ab7eb",
            pin = true,
        },
        {
            "mason-org/mason-lspconfig.nvim",
            -- Pin: release; tag v2.2.0; checkout date 2026-04-23; commit 0c2823e0418f3d9230ff8b201c976e84de1cb401
            tag = "v2.2.0",
            commit = "0c2823e0418f3d9230ff8b201c976e84de1cb401",
            pin = true,
            dependencies = {
                "mason-org/mason.nvim",
                "neovim/nvim-lspconfig",
            },
        
        },
        {
            "neovim/nvim-lspconfig",
            -- Pin: release; tag v2.9.0; checkout date 2026-05-07; commit f6738ef65dabade340b473d4ff2a1ad3352c10e7
            tag = "v2.9.0",
            commit = "f6738ef65dabade340b473d4ff2a1ad3352c10e7",
            pin = true,
        },
        {
            "nvimtools/none-ls.nvim",
            -- Pin: default-branch:main; no release/tag; checkout date 2026-06-02; commit 01f8e62ea11603e59ad9ff7afcfa94fd183f76d6
            commit = "01f8e62ea11603e59ad9ff7afcfa94fd183f76d6",
            pin = true,
        },
        {
            "SmiteshP/nvim-navic",
            -- Pin: default-branch:master; no release/tag; checkout date 2025-12-29; commit f5eba192f39b453675d115351808bd51276d9de5
            commit = "f5eba192f39b453675d115351808bd51276d9de5",
            pin = true,
            config = function()
                require("nvim-navic").setup()
            end,
        
        },

        --  autocomplete plugins
        {
            "hrsh7th/nvim-cmp",
            -- Pin: release; tag v0.0.2; checkout date 2025-01-07; commit 8c82d0bd31299dbff7f8e780f5e06d2283de9678
            tag = "v0.0.2",
            commit = "8c82d0bd31299dbff7f8e780f5e06d2283de9678",
            pin = true,
        },
        {
            "hrsh7th/cmp-omni",
            -- Pin: default-branch:main; no release/tag; checkout date 2023-09-24; commit 4ef610bbd85a5ee4e97e09450c0daecbdc60de86
            commit = "4ef610bbd85a5ee4e97e09450c0daecbdc60de86",
            pin = true,
        },
        {
            "hrsh7th/cmp-nvim-lsp",
            -- Pin: default-branch:main; no release/tag; checkout date 2025-11-13; commit cbc7b02bb99fae35cb42f514762b89b5126651ef
            commit = "cbc7b02bb99fae35cb42f514762b89b5126651ef",
            pin = true,
        },
        {
            "hrsh7th/cmp-buffer",
            -- Pin: default-branch:main; no release/tag; checkout date 2025-04-01; commit b74fab3656eea9de20a9b8116afa3cfc4ec09657
            commit = "b74fab3656eea9de20a9b8116afa3cfc4ec09657",
            pin = true,
        },
        {
            "hrsh7th/cmp-path",
            -- Pin: default-branch:main; no release/tag; checkout date 2025-07-30; commit c642487086dbd9a93160e1679a1327be111cbc25
            commit = "c642487086dbd9a93160e1679a1327be111cbc25",
            pin = true,
        },
        {
            "hrsh7th/cmp-cmdline",
            -- Pin: default-branch:main; no release/tag; checkout date 2025-05-18; commit d126061b624e0af6c3a556428712dd4d4194ec6d
            commit = "d126061b624e0af6c3a556428712dd4d4194ec6d",
            pin = true,
        },
        {
            "onsails/lspkind-nvim",
            -- Pin: default-branch:master; no release/tag; checkout date 2026-01-29; commit c7274c48137396526b59d86232eabcdc7fed8a32
            commit = "c7274c48137396526b59d86232eabcdc7fed8a32",
            pin = true,
        },
        {
            "saadparwaiz1/cmp_luasnip",
            -- Pin: default-branch:master; no release/tag; checkout date 2024-11-04; commit 98d9cb5c2c38532bd9bdb481067b20fea8f32e90
            commit = "98d9cb5c2c38532bd9bdb481067b20fea8f32e90",
            pin = true,
            dependencies = {
                "hrsh7th/nvim-cmp",
                "L3MON4D3/LuaSnip",
            },
        
        },
        {
            "L3MON4D3/LuaSnip",
            -- Pin: release; tag v2.5.0; checkout date 2026-04-05; commit 642b0c595e11608b4c18219e93b88d7637af27bc
            tag = "v2.5.0",
            commit = "642b0c595e11608b4c18219e93b88d7637af27bc",
            pin = true,
            build = "make install_jsregexp",
        
        },
        {
            "honza/vim-snippets",
            -- Pin: release; tag 1.0.0; checkout date 2014-05-16; commit 4ed409154bcaa32fba6fd153cc0c915e44982872
            tag = "1.0.0",
            commit = "4ed409154bcaa32fba6fd153cc0c915e44982872",
            pin = true,
        },

        -- treesitter plugins
        {
            "nvim-treesitter/nvim-treesitter",
            -- Pin: default-branch:main; no release/tag; checkout date 2026-04-03; commit 4916d6592ede8c07973490d9322f187e07dfefac
            commit = "4916d6592ede8c07973490d9322f187e07dfefac",
            pin = true,
            build = ":TSUpdate",

        },
        --    use("nvim-treesitter/nvim-treesitter-context") -- redundant with navic
        {
            "danymat/neogen",
            -- Pin: tag; tag 2.20.0; checkout date 2024-12-27; commit b2e78708876f4da507839726816010a68e33fec8
            tag = "2.20.0",
            commit = "b2e78708876f4da507839726816010a68e33fec8",
            pin = true,
        },

        {
            "hedyhli/outline.nvim",
            -- Pin: release; tag v1.2.0; checkout date 2026-01-31; commit ead1820d49c8e79ce89cab1c2c318981b695c9d2
            tag = "v1.2.0",
            commit = "ead1820d49c8e79ce89cab1c2c318981b695c9d2",
            pin = true,
            config = function()
                require("outline").setup({})
            end,
        
        },

        -- colorscheme
        {
            "NLKNguyen/papercolor-theme",
            -- Pin: release; tag v1.0; checkout date 2020-12-04; commit 20f1da518d09868bbf3c58ff04f2ae24b1edf23e
            tag = "v1.0",
            commit = "20f1da518d09868bbf3c58ff04f2ae24b1edf23e",
            pin = true,
        },
        {
            "rebelot/kanagawa.nvim",
            -- Pin: default-branch:master; no release/tag; checkout date 2026-05-10; commit bb85e4bfc8d89b0e62c8fa53ccdd13d12e2f77b3
            commit = "bb85e4bfc8d89b0e62c8fa53ccdd13d12e2f77b3",
            pin = true,
        },
        {
            "iruzo/matrix-nvim",
            -- Pin: default-branch:main; no release/tag; checkout date 2023-03-23; commit 5fafe6b440d08c1070e3c4c4cb9d648436d5d867
            commit = "5fafe6b440d08c1070e3c4c4cb9d648436d5d867",
            pin = true,
        },
        {
            "catppuccin/nvim",
            -- Pin: release; tag v2.0.0; checkout date 2026-04-02; commit 605b4603797de970e9f3a4238c199c850da03186
            tag = "v2.0.0",
            commit = "605b4603797de970e9f3a4238c199c850da03186",
            pin = true,
            name = "catppuccin",
        
        },

        {
            "glench/vim-jinja2-syntax",
            -- Pin: default-branch:master; no release/tag; checkout date 2021-06-22; commit 2c17843b074b06a835f88587e1023ceff7e2c7d1
            commit = "2c17843b074b06a835f88587e1023ceff7e2c7d1",
            pin = true,
        },

        -- fzf - this is only used for vimtex integration
        {
            "junegunn/fzf",
            -- Pin: release; tag v0.73.1; checkout date 2026-05-25; commit ce4bef75954bebd87e0886435bcf8c6904328ab0
            tag = "v0.73.1",
            commit = "ce4bef75954bebd87e0886435bcf8c6904328ab0",
            pin = true,
            build = function()
                vim.cmd([[call fzf#install()]])
            end,
        
        },

        -- telescope
        {
            "nvim-lua/plenary.nvim",
            -- Pin: tag; tag v0.1.4; checkout date 2023-10-11; commit 50012918b2fc8357b87cff2a7f7f0446e47da174
            tag = "v0.1.4",
            commit = "50012918b2fc8357b87cff2a7f7f0446e47da174",
            pin = true,
        }, -- Useful lua functions used ny lots of plugins
        {
            "nvim-telescope/telescope.nvim",
            -- Pin: release; tag v0.2.1; checkout date 2025-12-31; commit 3333a52ff548ba0a68af6d8da1e54f9cd96e9179
            tag = "v0.2.1",
            commit = "3333a52ff548ba0a68af6d8da1e54f9cd96e9179",
            pin = true,
            branch = "0.1.x",
            dependencies = {
                "nvim-lua/plenary.nvim",
            },
        
        },
        {
            "nvim-telescope/telescope-file-browser.nvim",
            -- Pin: default-branch:master; no release/tag; checkout date 2025-08-05; commit 3610dc7dc91f06aa98b11dca5cc30dfa98626b7e
            commit = "3610dc7dc91f06aa98b11dca5cc30dfa98626b7e",
            pin = true,
            dependencies = {
                "nvim-telescope/telescope.nvim",
            },
        
        },
        -- use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            -- Pin: default-branch:main; no release/tag; checkout date 2026-05-06; commit b25b749b9db64d375d782094e2b9dce53ad53a40
            commit = "b25b749b9db64d375d782094e2b9dce53ad53a40",
            pin = true,
            build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release',
            dependencies = {
                "nvim-telescope/telescope.nvim",
            },
        
        },
        {
            "nvim-telescope/telescope-ui-select.nvim",
            -- Pin: default-branch:master; no release/tag; checkout date 2023-12-04; commit 6e51d7da30bd139a6950adf2a47fda6df9fa06d2
            commit = "6e51d7da30bd139a6950adf2a47fda6df9fa06d2",
            pin = true,
            dependencies = {
                "nvim-telescope/telescope.nvim",
            },
        
        },
        {
            "benfowler/telescope-luasnip.nvim",
            -- Pin: default-branch:master; no release/tag; checkout date 2024-12-14; commit 07a2a2936a7557404c782dba021ac0a03165b343
            commit = "07a2a2936a7557404c782dba021ac0a03165b343",
            pin = true,
            dependencies = {
                "nvim-telescope/telescope.nvim",
                "L3MON4D3/LuaSnip",
            },
        
        },

        {
            "nvim-telescope/telescope-bibtex.nvim",
            -- Pin: default-branch:master; no release/tag; checkout date 2024-03-28; commit 289a6f86ebec06e8ae1590533b732b9981d84900
            commit = "289a6f86ebec06e8ae1590533b732b9981d84900",
            pin = true,
            dependencies = {
                "nvim-telescope/telescope.nvim",
            },
            config = function()
                require("telescope").load_extension("bibtex")
            end,
        
        },

        ------------------------------------
        ----------Utilities-----------------
        ------------------------------------
        ------- Coding utils -------
        {
            "tpope/vim-dispatch",
            -- Pin: tag; tag v1.8; checkout date 2019-06-09; commit 488940870ab478cc443b06d5a62fea7ab999eabf
            tag = "v1.8",
            commit = "488940870ab478cc443b06d5a62fea7ab999eabf",
            pin = true,
        },

        --- Language specific
        {
            "vim-scripts/a.vim",
            -- Pin: tag; tag 2.18; checkout date 2010-11-06; commit 2cbe946206ec622d9d8cf2c99317f204c4d41885
            tag = "2.18",
            commit = "2cbe946206ec622d9d8cf2c99317f204c4d41885",
            pin = true,
        }, -- switch from .h to .c via :A

        -- R language support
        {
            "jalvesaq/Nvim-R",
            -- Pin: release; tag v1.0.0; checkout date 2026-05-02; commit 82b570035e5502ac936e9c4cf8b6709469377253
            tag = "v1.0.0",
            commit = "82b570035e5502ac936e9c4cf8b6709469377253",
            pin = true,
            config = function()
                -- vim.cmd("let R_external_term = 1")
            end,
        
        },

        --vimiwiki & taskwarrior
        {
            "vimwiki/vimwiki",
            -- Pin: release; tag v2024.01.24; checkout date 2024-01-25; commit fde35bb87e45abe930eebef5ab99a16289e53789
            tag = "v2024.01.24",
            commit = "fde35bb87e45abe930eebef5ab99a16289e53789",
            init = function()
                vim.g.vimwiki_list = {
                    {
                        path = "~/Notes",
                        syntax = "markdown",
                        ext = ".md",
                        custom_wiki2html = "~/.local/scripts/vimwiki_convert.py",
                    },
                }

                vim.g.vimwiki_ext2syntax = {
                    [".md"] = "markdown",
                    [".markdown"] = "markdown",
                    [".mdown"] = "markdown",
                }

                vim.g.vimwiki_markdown_link_ext = 1
            end,
            config = function()
                vim.keymap.set("n", "<leader>ww", "<cmd>VimwikiIndex<CR>", {
                    noremap = true,
                    silent = true,
                    desc = "Open Vimwiki index",
                })
            end,
        },
        -- This kind of broke, i guess we would have to update the plugin or sth but im not usingit anyways rn
        -- {
        --     "tools-life/taskwiki",
        --     -- Pin: tag; tag 1.0.0; checkout date 2019-03-26; commit 056d9e82f57ee8d897151ff42ce7bc05fa55e7b8
        --     tag = "1.0.0",
        --     commit = "056d9e82f57ee8d897151ff42ce7bc05fa55e7b8",
        --     dependencies = {
        --         "vimwiki/vimwiki",
        --     },
        --     init = function()
        --         vim.g.taskwiki_markup_syntax = "markdown"
        --         vim.g.taskwiki_disable_concealcorser = 1
        --         vim.g.taskwiki_sort_order = "status+,end+,priority+,project+"
        --     end,
        -- },

        --disable - lag?
        --use({
        --     "gaoDean/autolist.nvim",
        --     tag = "*",
        --     config = function()
        --         require("autolist").setup({})
        --     end,
        --})

        --vimtex important
        {
            "lervag/vimtex",
            -- Pin: release; tag v2.17; checkout date 2025-10-04; commit 2e1bbabeb2c34bb17d7bc8cfdf8f95b16dd0db0c
            tag = "v2.17",
            commit = "2e1bbabeb2c34bb17d7bc8cfdf8f95b16dd0db0c",
            pin = true,
        },

        ----- MISC -----
        ---better quickfix; including preview and fzf support (press zf in qf win)
        -- use({ "kevinhwang91/nvim-bqf", ft = "qf" })

        -- use("tpope/vim-vinegar") -- navigation with -
        -- try oil istead
        {
            "stevearc/oil.nvim",
            -- Pin: release; tag v2.16.0; checkout date 2026-05-24; commit 17c0a8faaf48298a0c0cfb0d757c0eaee4ff7a32
            tag = "v2.16.0",
            commit = "17c0a8faaf48298a0c0cfb0d757c0eaee4ff7a32",
            pin = true,
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
        
        },

        -----Git------
        {
            "lewis6991/gitsigns.nvim",
            -- Pin: release; tag v2.1.0; checkout date 2026-03-26; commit a462f416e2ce4744531c6256252dee99a7d34a83
            tag = "v2.1.0",
            commit = "a462f416e2ce4744531c6256252dee99a7d34a83",
            pin = true,
            dependencies = {
                "petertriho/nvim-scrollbar",
            },
            config = function()
                require("gitsigns").setup()
                require("scrollbar.handlers.gitsigns").setup()
            end,
        
        },

        --general git
        {
            "tpope/vim-fugitive",
            -- Pin: tag; tag v3.7; checkout date 2022-06-07; commit 96c1009fcf8ce60161cc938d149dd5a66d570756
            tag = "v3.7",
            commit = "96c1009fcf8ce60161cc938d149dd5a66d570756",
            pin = true,
        },

        -- depends on fugitive. :Flog gives git history
        {
            "rbong/vim-flog",
            -- Pin: release; tag v3.0.0; checkout date 2024-09-06; commit e7a0e9f6f26d154b1e550de94414ea71e354c563
            tag = "v3.0.0",
            commit = "e7a0e9f6f26d154b1e550de94414ea71e354c563",
            pin = true,
            dependencies = {
                "tpope/vim-fugitive",
            },
        
        },

        {
            "sindrets/diffview.nvim",
            -- Pin: default-branch:main; no release/tag; checkout date 2024-06-13; commit 4516612fe98ff56ae0415a259ff6361a89419b0a
            commit = "4516612fe98ff56ae0415a259ff6361a89419b0a",
            pin = true,
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
        
        },

        {
            "nvim-lualine/lualine.nvim",
            -- Pin: tag; tag compat-nvim-0.6; checkout date 2023-10-18; commit c55af3b39cc50109aa75d445e38f2089b023e5df
            tag = "compat-nvim-0.6",
            commit = "c55af3b39cc50109aa75d445e38f2089b023e5df",
            pin = true,
            dependencies = {
                "kyazdani42/nvim-web-devicons",
            },
        
        },

        {
            "aserowy/tmux.nvim",
            -- Pin: default-branch:main; no release/tag; checkout date 2026-04-13; commit 32ceaf2793582955ef9576809730878c4d2d9426
            commit = "32ceaf2793582955ef9576809730878c4d2d9426",
            pin = true,
        },

        -- -- autoset directoryy to proj root
        {
            "DrKJeff16/project.nvim",
            tag =  "v5.0.0-1",
            pin = true,
            config = function()
                require("project").setup({
                    lsp = { ignore = { "null-ls", "r-language-server" } },
                    -- When set to false, you will get a message when project.nvim changes your
                    -- directory.
                    silent_chdir = true,
                    exclude_dirs = { "~" },
                })
            end,

        },

        {
            "windwp/nvim-autopairs",
            -- Pin: release; tag 0.10.0; checkout date 2025-09-26; commit 23320e75953ac82e559c610bec5a90d9c6dfa743
            tag = "0.10.0",
            commit = "23320e75953ac82e559c610bec5a90d9c6dfa743",
            pin = true,
        },
        {
            "junegunn/vim-easy-align",
            -- Pin: tag; tag 2.10.0; checkout date 2015-10-01; commit 0db4ea6132110631ec678a99a82aa49a0686ae65
            tag = "2.10.0",
            commit = "0db4ea6132110631ec678a99a82aa49a0686ae65",
            pin = true,
        },

        {
            "kylechui/nvim-surround",
            -- Pin: release; tag v4.0.5; checkout date 2026-05-02; commit 2e93e154de9ff326def6480a4358bfc149d5da2c
            tag = "v4.0.5",
            commit = "2e93e154de9ff326def6480a4358bfc149d5da2c",
            pin = true,
            config = function()
                require("nvim-surround").setup({
                })
            end,
        
        },

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
        {
            "kyazdani42/nvim-web-devicons",
            -- Pin: tag; tag nerd-v3.2-compat; checkout date 2024-12-07; commit 21417212f640a1dad28a1408f04468819848f5e7
            tag = "nerd-v3.2-compat",
            commit = "21417212f640a1dad28a1408f04468819848f5e7",
            pin = true,
            config = function()
                require("nvim-web-devicons").setup()
            end,
        
        },

        --visual guides for whitespaces, quite ncie
        {
            "lukas-reineke/indent-blankline.nvim",
            -- Pin: release; tag v3.9.1; checkout date 2026-02-17; commit d28a3f70721c79e3c5f6693057ae929f3d9c0a03
            tag = "v3.9.1",
            commit = "d28a3f70721c79e3c5f6693057ae929f3d9c0a03",
            main = "ibl",
            opts = {},
        
        },

        -- color picker and utilities
        {
            "NvChad/nvim-colorizer.lua",
            -- Pin: default-branch:master; no release/tag; checkout date 2026-05-30; commit 664c0b7cea1de71f8b65dfe951b7996fc3e6ccde
            commit = "664c0b7cea1de71f8b65dfe951b7996fc3e6ccde",
            pin = true,
            config = function()
                require("colorizer").setup()
            end,
        
        },

        --rh scrollbar
        {
            "petertriho/nvim-scrollbar",
            -- Pin: default-branch:main; no release/tag; checkout date 2025-11-17; commit f8e87b96cd6362ef8579be456afee3b38fd7e2a8
            commit = "f8e87b96cd6362ef8579be456afee3b38fd7e2a8",
            pin = true,
            config = function()
                require("scrollbar").setup()
            end,
        
        },

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
        missing = true,
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
