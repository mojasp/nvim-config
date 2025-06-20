vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true
vim.opt.pumheight = 10 -- pop up menu height
vim.opt.swapfile = false
vim.opt.ignorecase = true
vim.opt.smartcase = true -- smart case
vim.opt.smartindent = true -- smart indent
vim.opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
vim.opt.autoindent = true

vim.opt.spelllang="en_us,de_de"

vim.opt.signcolumn = "yes"
vim.opt.cursorline = false

vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.swapfile = false

 vim.cmd([[
   let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
   let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
   set t_ut=
   set termguicolors
]])

vim.opt.number = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.cmdheight = 1

vim.cmd([[
    set splitright
    set mouse=

    """""" command completion """"""
    set wildmenu
    set wildmode=longest:full,full
    set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx,*DS_STORE,*.db
]])

-- Multiline search via S: searches for whitespace separated arguments 
-- If used via S!, search tokens can be separated by anything
vim.cmd([[
function! SearchMultiLine(bang, ...)
  if a:0 > 0
    let sep = (a:bang) ? '\_W\+' : '\_s\+'
    let @/ = join(a:000, sep)
  endif
endfunction
command! -bang -nargs=* S call SearchMultiLine(<bang>0, <f-args>)|normal! /<C-R>/<CR>
]])

-- vimtex
vim.cmd([[
let g:vimtex_format_enabled=1
let g:vimtex_view_method='zathura'
]])
