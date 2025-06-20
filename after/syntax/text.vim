"conceal checkboxes
syntax match todoCheckbox "\v.*-\ \[\ \]"hs=e-4 conceal cchar=☐
syntax match todoCheckbox "\v.*-\ \[X\]"hs=e-4 conceal cchar=🗹
syntax match todoCheckbox "\v.*-\ \[x\]"hs=e-4 conceal cchar=🗹

syntax match todoCheckbox "\v.*\*\ \[\ \]"hs=e-4 conceal cchar=☐
syntax match todoCheckbox "\v.*\*\ \[X\]"hs=e-4 conceal cchar=🗹
syntax match todoCheckbox "\v.*\*\ \[x\]"hs=e-4 conceal cchar=🗹

" conceal standalone [ ] / [x] / [X]
syntax match todoCheckbox "\v\[\ \]" conceal cchar=☐
syntax match todoCheckbox "\v\[x\]" conceal cchar=🗹
syntax match todoCheckbox "\v\[X\]" conceal cchar=🗹

hi Conceal guibg=NONE
setlocal conceallevel=2
setlocal concealcursor=c
