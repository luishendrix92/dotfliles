" Change Leader Key to Space
nnoremap <SPACE> <Nop>
let maplocalleader=","
let mapleader=" "

" Plugins
" =======
call plug#begin("~/.local/share/nvim/plugged")
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'morhetz/gruvbox'
  Plug 'scrooloose/nerdtree'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  let g:coc_global_extensions = ['coc-css', 'coc-json']
  Plug 'leafgarland/typescript-vim'
  Plug 'peitalin/vim-jsx-typescript'
  Plug 'lervag/vimtex'
  Plug 'honza/vim-snippets'
  Plug 'nathanaelkane/vim-indent-guides'
  Plug 'kien/ctrlp.vim'
  Plug 'airblade/vim-gitgutter'
  Plug 'roman/golden-ratio'
  Plug 'benmills/vimux'
  Plug 'ryanoasis/vim-devicons'
  Plug 'overcache/NeoSolarized'
  Plug 'preservim/tagbar'
  Plug 'mlaursen/vim-react-snippets'
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
  Plug 'tpope/vim-fugitive'
  Plug 'jxnblk/vim-mdx-js'
  Plug 'elmcast/elm-vim'
  Plug 'Olical/conjure', {'tag': 'v4.22.1'}
call plug#end()

" Initial detection
" =================
if (has("termguicolors"))
  set termguicolors
endif
if has('autocmd')
  filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

if has("autocmd")
  au BufReadPost *.rkt,*.rktl set filetype=racket
endif

" NERDTree Configuration
" ======================
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
nnoremap <silent> <leader>t :NERDTreeToggle<CR>

" Integrated Terminal
" ===================
" Open new split panes to right and below
set splitright
set splitbelow
" Turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>
" Start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" Open terminal on ctrl+n
function! OpenTerminal()
  split term://bash
  resize 10
endfunction
nnoremap <c-n> :call OpenTerminal()<CR>

" Editor related
" ==============
set encoding=UTF-8
set nobackup
set noswapfile
set number relativenumber
set tabstop=2 shiftwidth=2 expandtab
set smartindent
let hlstate=0
nnoremap<silent> <F4> :if (hlstate == 0) \| nohlsearch \| else \| set hlsearch \| endif \| let hlstate=1-hlstate<CR>
set ttimeoutlen=100

let g:typescript_indent_disable = 1

" CTRL-P
" ======
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.yardoc\|node_modules\|log\|tmp$',
  \ }

" Visual and themes
" =================
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" Set color scheme according to time
set bg=dark
colorscheme gruvbox
let g:airline_theme= 'gruvbox'

highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)
set conceallevel=2

" Vimtex and Latex
" ================
let g:tex_flavor = 'latex'
let g:vimtex_compiler_latexmk = {'build_dir' : 'out'}

" Conquer of Completion
" =====================
"Make TAB used for trigger completion, expand and jump
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

autocmd FileType javascript,javascriptreact,typescript,typescriptreact,elm nnoremap <silent> K :call CocAction('doHover')<CR>
nmap <leader>do <Plug>(coc-codeaction)
nmap <leader>rn <Plug>(coc-rename)
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gy <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)

" Vim Remaps
" ==========
nnoremap <TAB> :bnext<CR>
nnoremap <S-TAB> :bprevious<CR>
nnoremap <C-s> :w<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Vimux Remaps
" ============
let g:VimuxUseNearest = 0
let g:VimuxHeight = "40"

" Custom motions
map <Leader><Up> :move -2<CR>
map <Leader><Down> :move +1<CR>

" Custom runners
map<silent> <Leader>g+ :call VimuxRunCommand("clear; g++ -o " . expand("%:r") . " " . bufname("%") . " -std=c++17 && ./" . expand("%:r"))<CR>
map<silent> <Leader>ns :call VimuxRunCommand("npm start")<CR>
map<silent> <Leader>el :call VimuxRunCommand("elm-live src/Main.elm -- --output=elm.js")<CR>

map <Leader>vp :VimuxPromptCommand<CR>
map <Leader>vl :VimuxRunLastCommand<CR>
map <Leader>vi :VimuxInspectRunner<CR>
map <Leader>vq :VimuxCloseRunner<CR>
map <Leader>vz :call VimuxZoomRunner()<CR>

function! VimuxSlime()
  call VimuxSendText(@v)
  call VimuxSendKeys("Enter")
endfunction

" If text is selected, save it in the v buffer and send that buffer it to tmux
vmap <LocalLeader>vs "vy :call VimuxSlime()<CR>

" Select current paragraph and send it to tmux
nmap <LocalLeader>vs vip<LocalLeader>vs<CR>
