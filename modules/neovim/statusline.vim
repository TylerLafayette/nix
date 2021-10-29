" Disable the `-- INSERT --` etc. below the StatusLine
set noshowmode

" Declarations for how to display modes
let g:currentmode={
       \ 'n'  :     '  🤔  ',
       \ 'v'  :     '  🔍  ',
       \ 'V'  :     ' 🔍 • ',
       \ "\<C-V>" : ' 🔍 ° ',
       \ 'i'  :     '  📝  ',
       \ 'R'  :     '  ♻️   ',
       \ 'Rv' :     '  ♻️   ',
       \ 'c'  :     '  💿  ',
       \ 't'  :     '  🔦  ',
       \}

" Reset the status line
set statusline=

" Show the mode on the status line
set statusline+=~%{g:currentmode[mode()]}

" Show the git branch (if one exists)
function! StatuslineGit()
  let l:branchname = gitbranch#name()
  return strlen(l:branchname) > 0?' | '.l:branchname.'':''
endfunction

set statusline+=%{StatuslineGit()}

" Colors
augroup highlights 
	autocmd!
	autocmd ColorScheme * hi StatusLine gui=NONE guibg=terminal_color_0
"			  \ | 
augroup END
