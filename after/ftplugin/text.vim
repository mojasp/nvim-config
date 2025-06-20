" Map Ctrl-Space in normal mode to toggle checkbox
nnoremap <buffer> <C-Space> :call ToggleCheckbox()<CR>

function! ToggleCheckbox()
  let l:line = getline('.')
  let l:col = col('.')

  " Match a checkbox at or after the cursor position
  let l:start = match(l:line, '\[\zs[ xX]\ze\]', l:col - 1)

  if l:start >= 0
    let l:char = l:line[l:start]
    if l:char =~# '[xX]'
      let l:newline = substitute(l:line, '\[\zs[xX]\ze\]', ' ', '')
    else
      let l:newline = substitute(l:line, '\[\zs \ze\]', 'x', '')
    endif
    call setline('.', l:newline)
  else
    echo "No checkbox found on this line"
  endif
endfunction
