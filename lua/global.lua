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

vim.opt.exrc = true
vim.opt.secure = true

-- List all the TODOS added in a git diff
-- Vibe Coded this, but seems to work
vim.api.nvim_create_user_command(
    'TodosAdded',
    function(opts)
        vim.cmd([[
:cgetexpr systemlist(["sh","-lc","git diff --no-color -U0 origin/HEAD | awk 'BEGIN{IGNORECASE=1} /^\\+\\+\\+ /{f=$2; sub(/^b\\//,\"\",f); next} /^@@/ {h=$0; sub(/^.*\\+/,\"\",h); sub(/[, ].*$/, \"\", h); ln=h+0; next} /^\\+/ && $0 !~ /^\\+\\+\\+/ {s=substr($0,2); if (s ~ /TODO/) printf \"%s:%d: %s\\n\", f, ln, s; ln++; next} /^ /{ln++}'"]) | cwindow
]])
    end,
    {nargs = 0}
)

-- List all added prints in a git diff
-- Vibe Coded this, but seems to work
vim.api.nvim_create_user_command(
    'PrintsAdded',
    function(opts)
        vim.cmd([[
:cgetexpr systemlist(["sh","-lc","git diff --no-color -U0 origin/HEAD | awk 'BEGIN{IGNORECASE=1} /^\\+\\+\\+ /{f=$2; sub(/^b\\//,\"\",f); next} /^@@/ {h=$0; sub(/^.*\\+/,\"\",h); sub(/[, ].*$/, \"\", h); ln=h+0; next} /^\\+/ && $0 !~ /^\\+\\+\\+/ {s=substr($0,2); if (s ~ /println|dbg!/) printf \"%s:%d: %s\\n\", f, ln, s; ln++; next} /^ /{ln++}'"]) | cwindow
]])
    end,
    {nargs = 0}
)


vim.api.nvim_create_autocmd("BufWinEnter", {
  group = vim.api.nvim_create_augroup("FugitiveJump", { clear = true }),
  pattern = "fugitive:///*",
  callback = function()
    vim.cmd("normal! 5j")
  end,
})
