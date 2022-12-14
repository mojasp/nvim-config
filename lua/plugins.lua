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
    use("jose-elias-alvarez/null-ls.nvim")
    use({
        "SmiteshP/nvim-navic",
        config = function()
            require("nvim-navic").setup()
        end,
    })
    use("lvimuser/lsp-inlayhints.nvim")
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
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-cmdline")
    use("onsails/lspkind-nvim")
    use("saadparwaiz1/cmp_luasnip")
    use("L3MON4D3/LuaSnip")
    use("honza/vim-snippets")
    use({
        "zbirenbaum/copilot.lua",
        event = { "VimEnter" },
        config = function()
            vim.defer_fn(function()
                require("user.copilot")
            end, 100)
        end,
    })
    use("zbirenbaum/copilot-cmp")
    use({
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = function()
            require("lsp_lines").setup()
        end,
    })
    use({
        "dccsillag/magma-nvim",
        run = ":UpdateRemotePlugins",
        config = function()
            vim.cmd([[
                    nnoremap <silent><expr> <LocalLeader>r  :MagmaEvaluateOperator<CR>
                    nnoremap <silent>       <LocalLeader>rr :MagmaEvaluateLine<CR>
                    xnoremap <silent>       <LocalLeader>r  :<C-u>MagmaEvaluateVisual<CR>
                    nnoremap <silent>       <LocalLeader>rc :MagmaReevaluateCell<CR>
                    nnoremap <silent>       <LocalLeader>rd :MagmaDelete<CR>
                    nnoremap <silent>       <LocalLeader>ro :MagmaShowOutput<CR>

                    let g:magma_automatically_open_output = v:false
                    let g:magma_image_provider = "ueberzug"
                ]])
        end,
    })

    -- treesitter plugins
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        -- commit = "4cccb6f"  # there was a breaking change in this commit - pin it? maybe fixd now
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
    use({ "ellisonleao/gruvbox.nvim" })
    use({
        "catppuccin/nvim",
        config = function()
            require("catppuccin").setup()
        end,
    })
    use("EdenEast/nightfox.nvim") -- Packer
    use("rebelot/kanagawa.nvim")

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

    ------------------------------------
    ----------Utilities-----------------
    ------------------------------------
    --cache for faster startup
    use({
        "lewis6991/impatient.nvim",
        config = function()
            require("impatient")
        end,
    })
    ------- Coding utils -------
    use("tpope/vim-dispatch")
    use({
        "ojroques/nvim-buildme",
        lock = true,
        config = function()
            require("buildme").setup({ wincmd = "vsplit" })
        end,
    })
    use({
        "neomake/neomake",
        config = function()
            vim.g.neomake_open_list = 1
        end,
    })

    use({
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    })

    --- Language specific
    use("vim-scripts/a.vim")
    use({
        "jalvesaq/Nvim-R",
        config = function()
            -- vim.cmd("let R_external_term = 1")
        end,
    })
    use({
        "iamcco/markdown-preview.nvim",
        run = function()
            vim.fn["mkdp#util#install"]()
        end,
    })
    use("vimwiki/vimwiki")
    use("tools-life/taskwiki")
    use({
        "gaoDean/autolist.nvim",
        tag = "*",
        config = function()
            require("autolist").setup({})
        end,
    })

    use("lervag/vimtex")

    ----- MISC -----
    --use("tpope/vim-vinegar")
    use("mattn/calendar-vim")
    use({
        "KadoBOT/nvim-spotify",
        requires = "nvim-telescope/telescope.nvim",
        config = function()
            local spotify = require("nvim-spotify")

            spotify.setup({
                -- default opts
                status = {
                    update_interval = 10000, -- the interval (ms) to check for what's currently playing
                    format = "%s %t by %a", -- spotify-tui --format argument
                },
            })
        end,
        run = "make",
    })

    -----Git------
    use({
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
            require("scrollbar.handlers.gitsigns").setup()
        end,
    })
    use("tpope/vim-fugitive")
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
    use({
        "kyazdani42/nvim-tree.lua",
        requires = {
            "kyazdani42/nvim-web-devicons", -- optional, for file icons
        },
    })
    use({ "windwp/nvim-autopairs" })
    use({ "junegunn/vim-easy-align" })
    use({
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require("nvim-surround").setup({})
        end,
    })
    --Color picker, :CccPick to use
    use({
        "uga-rosa/ccc.nvim",
        config = function()
            require("ccc").setup({})
        end,
    })

    ----------- Project mgmt ---------
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
    use({
        "nvim-zh/colorful-winsep.nvim",
        config = function()
            require("colorful-winsep").setup({})
        end,
    })
    use({
        "kyazdani42/nvim-web-devicons",
        config = function()
            require("nvim-web-devicons").setup()
        end,
    })
    use("rcarriga/nvim-notify")
    use("lukas-reineke/indent-blankline.nvim")
    use({
        "NvChad/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup()
        end,
    })
    use({
        "petertriho/nvim-scrollbar",
        config = function()
            require("scrollbar").setup()
        end,
    })

    -------------------------------
    ------Debugger-----------------
    -------------------------------
    use("mfussenegger/nvim-dap")
    use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
    use({
        "theHamsta/nvim-dap-virtual-text",
        config = function()
            require("nvim-dap-virtual-text").setup()
        end,
    })

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
