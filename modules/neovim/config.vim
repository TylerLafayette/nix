" Allows usage of rich colors in colorscheme
set termguicolors

" Set our colorscheme
colorscheme iceberg

" Colorscheme overrides
augroup line_highlights
	autocmd!
	autocmd ColorScheme * hi LineNr 	gui=NONE guibg=NONE
			  \ | hi CursorLineNr 	gui=NONE guibg=NONE
augroup END

" Relative numbers (with current absolute number shown next to cursor)
set number relativenumber

" Configure fzf colors
let g:fzf_colors =
\ { 'fg': ['fg', 'Normal'],
\ 'bg': ['bg', 'Normal'],
\ 'hl': ['fg', 'Comment'],
\ 'fg+': ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
\ 'bg+': ['bg', 'Normal', 'Normal'],
\ 'hl+': ['fg', 'Statement'],
\ 'info': ['fg', 'PreProc'],
\ 'border': ['fg', 'Ignore'],
\ 'prompt': ['fg', 'Conditional'],
\ 'pointer': ['fg', 'Exception'],
\ 'marker': ['fg', 'Keyword'],
\ 'spinner': ['fg', 'Label'],
\ 'header': ['fg', 'Comment'] }
