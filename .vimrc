if has("syntax")
  syntax on
endif

execute pathogen#infect()
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

"let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='solarized'

" Editor settings
set number
set t_Co=256
set tabstop=2 shiftwidth=2 expandtab
set smartindent
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)
let hlstate=0

" Key mappings and remappings
map <C-k><C-b> :NERDTreeToggle<CR>
nnoremap <F4> :if (hlstate == 0) \| nohlsearch \| else \| set hlsearch \| endif \| let hlstate=1-hlstate<CR>