local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init({
    auto_reload_compiled = true,
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
})

-- Install your plugins here
return packer.startup(function(use)
    use("wbthomason/packer.nvim") -- Have packer manage itself

    -- nvimlsp plugins
    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")
    use("neovim/nvim-lspconfig")
    use("nvimtools/none-ls.nvim")
    use({
        "SmiteshP/nvim-navic",
        config = function()
            require("nvim-navic").setup()
        end,
    })
    use({
        "ray-x/lsp_signature.nvim",
        config = function()
            require("lsp_signature").setup({
                toggle_key = "<C-S>",
                select_signature_key = "<C-E>",
                hint_enable = false,
            })
        end,
    })

    --  autocomplete plugins
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-omni")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-cmdline")
    use("onsails/lspkind-nvim")
    use("saadparwaiz1/cmp_luasnip")
    use({ "L3MON4D3/LuaSnip", run = "make install_jsregexp" })
    use("honza/vim-snippets")
    -- packer.nvim
    use({
        "robitx/gp.nvim",
        config = function()
            local conf = {
                -- For customization, refer to Install > Configuration in the Documentation/Readme
            }
            require("gp").setup(conf)

            -- Setup shortcuts here (see Usage > Shortcuts in the Documentation/Readme)
        end,
    })

    -- treesitter plugins
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    })
    use("nvim-treesitter/nvim-treesitter-refactor")
    --    use("nvim-treesitter/nvim-treesitter-context") -- redundant with navic
    use("danymat/neogen")

    --sidebar
    use({
        "simrat39/symbols-outline.nvim",
        config = function()
            require("symbols-outline").setup()
        end,
    })

    -- colorscheme
    use("rebelot/kanagawa.nvim")
    use("iruzo/matrix-nvim")
    use({ "catppuccin/nvim", as = "catppuccin" })

    -- fzf - this is only used for vimtex integration
    use({
        "junegunn/fzf",
        run = function()
            vim.cmd([[call fzf#install()]])
        end,
    })
    -- telescope
    use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
    use({
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        requires = { { "nvim-lua/plenary.nvim" } },
    })
    use("nvim-telescope/telescope-file-browser.nvim")
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
    use({ "nvim-telescope/telescope-ui-select.nvim" })
    use({
        "benfowler/telescope-luasnip.nvim",
    })

    use({
        "nvim-telescope/telescope-bibtex.nvim",
        requires = {
            { "nvim-telescope/telescope.nvim" },
        },
        config = function()
            require("telescope").load_extension("bibtex")
        end,
    })
    ------------------------------------
    ----------Utilities-----------------
    ------------------------------------
    --cache for faster startup
    ------- Coding utils -------
    -- use("tpope/vim-dispatch") - good dispatch thing; not using it atm
    --  same for all the others
    -- use({
    --     "ojroques/nvim-buildme",
    --     lock = true,
    --     config = function()
    --         require("buildme").setup({ wincmd = "vsplit" })
    --     end,
    -- })
    -- use({
    --     "neomake/neomake",
    --     config = function()
    --         vim.g.neomake_open_list = 1
    --     end,
    -- })

    -- http client etc.
    use({
        "rest-nvim/rest.nvim",
        requires = {
            { 'j-hui/fidget.nvim' }
        }
    })

    --- Language specific
    use("vim-scripts/a.vim") -- switch from .h to .c via :A
    -- R language support
    use({
        "jalvesaq/Nvim-R",
        config = function()
            -- vim.cmd("let R_external_term = 1")
        end,
    })
    use {
        "sylvanfranklin/omni-preview.nvim",
        requires = {
            {
                "toppair/peek.nvim",
                run = "deno task --quiet build:fast"
            }
        },
        config = function()
            require("omni-preview").setup()
            require("peek").setup({ app = "browser" }) -- this sets the app used to open the preview
        end
    }
    --vimiwiki & taskwarrior
    use("vimwiki/vimwiki")
    use("tools-life/taskwiki") --taskwarrior support for vimwiki
    --disable - lag?
    --use({
    --     "gaoDean/autolist.nvim",
    --     tag = "*",
    --     config = function()
    --         require("autolist").setup({})
    --     end,
    -- })

    --vimtex important
    use("lervag/vimtex")

    ----- MISC -----
    ---better quickfix; including preview and fzf support (press zf in qf win)
    use({ "kevinhwang91/nvim-bqf", ft = "qf" })

    use("tpope/vim-vinegar") -- navigation with -

    -----Git------
    use({
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
            require("scrollbar.handlers.gitsigns").setup()
        end,
    })

    --gitsigns does the same but is too slow. Adds virtual text blame with :GitBlameToggle
    use({
        "f-person/git-blame.nvim",
        config = function()
            vim.cmd("let g:gitblame_enabled=0")
        end,
    })

    --general git
    use("tpope/vim-fugitive")
    -- depends on fugitive. :Flog gives git history
    use("rbong/vim-flog")
    use({
        "sindrets/diffview.nvim",
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
    })

    use({
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
    })
    use("aserowy/tmux.nvim")
    -- will autoset directoryy
    use({
        "ahmedkhalf/project.nvim",
        config = function()
            require("project_nvim").setup({
                ignore_lsp = { "null-ls", "r-language-server" },
                -- When set to false, you will get a message when project.nvim changes your
                -- directory.
                silent_chdir = true,
                exclude_dirs = { "~" },
            })
        end,
    })
    use({ "windwp/nvim-autopairs" })
    use({ "junegunn/vim-easy-align" })
    use({
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require("nvim-surround").setup({
            })
        end,
    })

    ----------- Project mgmt ---------
    -- projet specific config very ncie
    use({
        --project local configs
        "MunifTanjim/exrc.nvim",
        -- disable built-in local config file support
        config = function()
            vim.o.exrc = false
            require("exrc").setup({
                files = {
                    ".nvimrc.lua",
                    ".nvimrc",
                    ".exrc.lua",
                    ".exrc",
                },
            })
        end,
    })

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
    -- })
    use({
        "kyazdani42/nvim-web-devicons",
        config = function()
            require("nvim-web-devicons").setup()
        end,
    })
    --visual guides for whitespaces, quite ncie
    use({ "lukas-reineke/indent-blankline.nvim", tag = "v2.20.8" })
    -- color picker and utilities
    use({
        "NvChad/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup()
        end,
    })

    --rh scrollbar
    use({
        "petertriho/nvim-scrollbar",
        config = function()
            require("scrollbar").setup()
        end,
    })

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

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
