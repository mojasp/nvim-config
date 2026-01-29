" compiler/flake8.vim
if exists("current_compiler")
  finish
endif
let current_compiler = "flake8"

" IMPORTANT: no ANSI colors in quickfix parsing
setlocal makeprg=flake8\ --color=never\ --ignore=E501

" flake8 default output:
" path/to/file.py:12:34: E123 message...
setlocal errorformat=%f:%l:%c:\ %m
