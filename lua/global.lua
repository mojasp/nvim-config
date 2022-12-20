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
vim.opt.cmdheight = 1

vim.cmd([[
    " general
    " set spelllang=en_us
    " set spelllang+=cjk
    " set spell
    " syntax on
    set splitright
    set mouse=
]])

-- no netrwo: using nvim-tree

-- vim.g.loaded = 1
-- vim.g.loaded_netrwPlugin = 1
vim.cmd([[
"""""" netrw """"""
    let g:netrw_browse_split = 4
]])

vim.cmd([[
    """""" command completion """"""
    set wildmenu
    set wildmode=longest:full,full
    set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx,*DS_STORE,*.db
]])

-- vimtex
vim.cmd([[
"" sioyek viewer
let g:vimtex_view_method='sioyek'
let g:vimtex_callback_progpath ='/home/moritz/.local/bin/nvim'

"" setup rpc for syiotek/vimtex inverse search
" function! SetServerName()
"   if has('win32')
"     let nvim_server_file = $TEMP . "/curnvimserver.txt"
"   else
"     let nvim_server_file = "/tmp/curnvimserver.txt"
"   endif
"   let cmd = printf("echo %s > %s", v:servername, nvim_server_file)
"   call system(cmd)
" endfunction
"
" augroup vimtex_common
"     autocmd!
"     autocmd FileType tex call SetServerName()
" augroup END
]])
