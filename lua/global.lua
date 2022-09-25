vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true
vim.opt.pumheight = 10 -- pop up menu height
vim.opt.swapfile = false
vim.opt.ignorecase = true
vim.opt.smartcase = true -- smart case
vim.opt.smartindent = true -- smart indent
vim.opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
vim.opt.autoindent = true

vim.opt.signcolumn = "yes"
vim.opt.cursorline = true

vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.swapfile = false

vim.opt.termguicolors = true

vim.opt.number = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.cmdheight = 1

vim.opt.relativenumber = true

vim.cmd([[
    " general
    " set spelllang=en_us
    " set spelllang+=cjk
    " set spell
    " syntax on
    set splitright
    set mouse=
]])

vim.cmd([[
"""""" netrw """"""
    let g:netrw_fastbrowse = 0
    let g:netrw_banner=0
    let g:netrw_keepdir = 0
    let g:netrw_liststyle = 3
    let g:netrw_altv = 1
    let g:netrw_browse_split = 4
    autocmd FileType netrw setl bufhidden=wipe
]])

vim.cmd([[
    """""" command completion """"""
    set wildmenu
    set wildmode=longest:full,full
    set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx,*DS_STORE,*.db
]])
