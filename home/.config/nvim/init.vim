let mapleader =","

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
	Plug 'itchyny/lightline.vim'
	Plug 'suan/vim-instant-markdown', {'rtp': 'after'}
    Plug 'frazrepo/vim-rainbow'
	Plug 'scrooloose/nerdtree'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    Plug 'ryanoasis/vim-devicons'
	Plug 'dracula/vim'
	Plug 'junegunn/vim-emoji'
	Plug 'junegunn/goyo.vim'
	Plug 'jreybert/vimagit'
	Plug 'vim-python/python-syntax'
	Plug 'vimwiki/vimwiki'
	Plug 'tpope/vim-commentary'
	Plug 'ap/vim-css-color'
	Plug 'lukesmithxyz/vimling'
	Plug 'morhetz/gruvbox'
	Plug 'shinchu/lightline-gruvbox.vim'
call plug#end()

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

set nocompatible
set tabstop=4 softtabstop=4
set shiftwidth=4
set smartcase
set ignorecase
set path+=**					" Searches current directory recursively.
set wildmenu					" Display all matches when tab complete.
set wildmode=longest,list,full  " Enable autocompletion:
set incsearch                   " Incremental search
set hidden                      " Needed to keep multiple buffers open
set nobackup                    " No auto backups
set noswapfile                  " No swap
set number						" Display line numbers
set clipboard=unnamedplus       " Copy/paste between vim and other programs.
syntax on
set termguicolors

"colorscheme dracula
colorscheme gruvbox

let g:lightline = {
	  \ 'colorscheme': 'gruvbox',
	  \ 'background': 'dark',
	  \ }

"let g:lightline = {
"	  \ 'background': 'dark',
"	  \ 'colorscheme': 'dracula',
"	  \ }

:hi normal guibg=0000000
" set bg=dark


" Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" Goyo plugin makes text more readable when writing prose:
	map <leader>f :Goyo \| set bg=light \| set linebreak<CR>
" Spell-check set to <leader>o, 'o' for 'orthography':
	map <leader>o :setlocal spell! spelllang=en_us<CR>


" Turns off highlighting on the bits of code that are changed, so the line that is changed is highlighted but the actual text that has changed stands out on the line and is readable.

if &diff
    highlight! link DiffText MatchParen
endif

" Save file as sudo on files that require root permission
	cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Function for toggling the bottom statusbar:
let s:hidden_all = 1
function! ToggleHiddenAll()
    if s:hidden_all  == 0
        let s:hidden_all = 1
        set noshowmode
        set noruler
        set laststatus=0
        set noshowcmd
    else
        let s:hidden_all = 0
        set showmode
        set ruler
        set laststatus=2
        set showcmd
    endif
endfunction
nnoremap <leader>h :call ToggleHiddenAll()<CR>

" Compile document, be it groff/LaTeX/markdown/etc.
	map <leader>c :w! \| !compiler "<c-r>%"<CR>

" Open corresponding .pdf/.html or preview
	map <leader>p :!opout <c-r>%<CR><CR>

map <leader>n :NERDTreeToggle<CR>
	let g:NERDTreeDirArrowExpandable = '►'
	let g:NERDTreeDirArrowCollapsible = '▼'
	let NERDTreeShowLineNumbers=1
	let NERDTreeShowHidden=1
	let NERDTreeMinimalUI = 1
	let g:NERDTreeWinSize=38

" vimling:
	nm <leader><leader>d :call ToggleDeadKeys()<CR>
	imap <leader><leader>d <esc>:call ToggleDeadKeys()<CR>a
	nm <leader><leader>i :call ToggleIPA()<CR>
	imap <leader><leader>i <esc>:call ToggleIPA()<CR>a
	nm <leader><leader>q :call ToggleProse()<CR>

" Automatically deletes all trailing whitespace and newlines at end of file on save.
	autocmd BufWritePre * %s/\s\+$//e
	autocmd BufWritePre * %s/\n\+\%$//e
	autocmd BufWritePre *.[ch] %s/\%$/\r/e
