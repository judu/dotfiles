" Vundle part
set nocompatible
filetype off
let g:vundle_default_git_proto='git'
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()
Plugin 'gmarik/vundle'
Plugin 'vim-scripts/Command-T'
Plugin 'briangershon/html5.vim'
Plugin 'vim-scripts/molokai'
Plugin 'git://vim-latex.git.sourceforge.net/gitroot/vim-latex/vim-latex'
Plugin 'mattn/emmet-vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'plasticboy/vim-markdown'
Plugin 'edsono/vim-matchit'
Plugin 'vim-scripts/gnupg.vim'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-fugitive'
Plugin 'MarcWeber/vim-addon-local-vimrc'
Plugin 'scrooloose/syntastic'
Plugin 'bitc/vim-hdevtools'

call vundle#end()
filetype plugin indent on
" End Vundle part


let g:local_vimrc = {'names':['.lvimrc'],'hash_fun':'LVRHashOfFile'}

set ofu=syntaxcomplete#Complete
set completeopt=longest,menuone

syntax on
filetype on
set hidden
set lazyredraw
set showmode
set nobackup
set nowritebackup
set noswapfile
set incsearch
set autoread
set hlsearch

" Command-T plugin ignore files.
set wildignore+=*.class,target,node_modules,bower_components

" Color scheme
set t_Co=256
let g:solarized_termcolors=256      " use solarized 256 fallback


" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

let g:molokai_original = 1
" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*


source ~/.vimrc.bepo

" Let's make it easy to edit this file (mnemonic for the key sequence is
" 'e'dit 'v'imrc)
nmap <silent> ,ev :e $MYVIMRC<cr>

" And to source this file as well (mnemonic for the key sequence is
" 's'ource 'v'imrc)
nmap <silent> ,sv :so $MYVIMRC<cr>

" Toggle line number display
nmap <silent> ,sn :set invnumber<CR>:set number?<CR>

" Switch to # buffer
nmap <silent> ,b :b#<CR>

" Save the current buffer
nmap <silent> ,ss :w<CR>

" Toggle paste mode
nmap  ,p :set invpaste<CR>:set paste?<CR>

" Turn off that stupid highlight search
nmap  ,n :set invhls<CR>:set hls?<CR>

" Set text wrapping toggles
nmap  ,w :set invwrap<CR>:set wrap?<CR>

" Set up retabbing on a source file
nmap  ,rr :1,$retab<CR>

" cd to the directory containing the file in the buffer
nmap  ,cd :lcd %:h<CR>

" Make the directory that contains the file in the current buffer.
" This is useful when you edit a file in a directory that doesn't
" (yet) exist
nmap  ,md :!mkdir -p %:p:h<CR>

"Command-T mappings
noremap <leader>f :CommandTFlush<cr>\|:CommandT<cr>
noremap <leader>h :CommandTFlush<cr>\|:CommandTBuffer<cr>

" Move the cursor to the window left of the current one
nmap <silent> ,c :wincmd h<cr>

" Move the cursor to the window below the current one
nmap <silent> ,t :wincmd j<cr>

" Move the cursor to the window above the current one
nmap <silent> ,s :wincmd k<cr>

" Move the cursor to the window right of the current one
nmap <silent> ,r :wincmd l<cr>

" Close the window below this one
nmap <silent> ,ct :wincmd j<cr>:close<cr>

" Close the window above this one
nmap <silent> ,cs :wincmd k<cr>:close<cr>

" Close the window to the left of this one
nmap <silent> ,cc :wincmd h<cr>:close<cr>

" Close the window to the right of this one
nmap <silent> ,cr :wincmd l<cr>:close<cr>

" Close the current window
nmap <silent> ,cC :close<cr>

" Move the current window to the right of the main Vim window
nmap <silent> ,mr <C-W>L

" Move the current window to the top of the main Vim window
nmap <silent> ,ms <C-W>K

" Move the current window to the left of the main Vim window
nmap <silent> ,mc <C-W>H

" Move the current window to the bottom of the main Vim window
nmap <silent> ,mt <C-W>J

" map à to = (like in gg=G)
noremap <silent> à =

" Get the current file's directory faster.
cnoremap %% <C-R>=expand('%:h').'/'<cr>

map <leader>e :edit %%

function! NumberToggle()
  set invrelativenumber
endfunc

nnoremap ,rn :set invrelativenumber<cr>

set laststatus=2

" command line size N
set ch=1

set stl=%f\ %m\ %r\ Line:\ %l/%L[%p%%]\ Col:\ %c\ Buf:\ #%n\ [%b][0x%B]

" Hide the mouse pointer while typing
set mousehide


" The GUI (i.e. the 'g' in 'gvim') is fantastic, but let's not be
" silly about it :)  The GUI is fantastic, but it's fantastic for
" its fonts and its colours, not for its toolbar and its menus -
" those just steal screen real estate
set guioptions=ac

" This is the timeout used while waiting for user input on a
" multi-keyed macro or while just sitting and waiting for another
" key to be pressed measured in milliseconds.
"
" i.e. for the ",d" command, there is a "timeoutlen" wait
"      period between the "," key and the "d" key.  If the
"      "d" key isn't pressed before the timeout expires,
"      one of two things happens: The "," command is executed
"      if there is one (which there isn't) or the command aborts.
"
" The idea here is that if you have two commands, say ",dv" and
" ",d" that it will take 'timeoutlen' milliseconds to recognize
" that you're going for ",d" instead of ",dv"
"
" In general you should endeavour to avoid that type of
" situation because waiting 'timeoutlen' milliseconds is
" like an eternity.
set timeoutlen=500

" These commands open folds
set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo

" Syntax coloring lines that are too long just slows down the world
set synmaxcol=2048
" Keep some stuff in the history
set history=100

" Next is for Latex
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_ViewRule_pdf='evince'
let g:Tex_CompileRule_pdf='pdflatex --interaction=nonstopmode $*'
let g:tex_flavor='latex'
let g:Tex_MultipleCompileFormats='pdf,dvi'
" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
" set iskeyword+=:

"augroup vimrcEx
"	autocmd!
"	autocmd BufReadPost *
"		\ if line("'\"") > 0 && line("'\"") <= line("$") |
"		\ exe "normal g`\"" |
"		\ endif
"augroup END

" Set the indentation right
set sw=3 ts=3 sts=0 noexpandtab
" set the right margin to 80 characters
set tw=90

" solarized stuff
let g:solarized_contrast='high'
let g:solarized_termtrans=1
colorscheme solarized

" airline recommended default config
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='solarized'

highlight RedundantSpaces ctermbg=124 guibg=red
match RedundantSpaces /\s\+$/

highlight UnbreakableSpaces ctermbg=237 guibg=orange
match UnbreakableSpaces / /

" Disable syntastic for java.
let g:syntastic_java_checkers = []

" Use Hdevtools with haskell files.
au FileType haskell nnoremap <buffer> <F1> :HdevtoolsType<CR>
au FileType haskell nnoremap <buffer> <silent> <F2> :HdevtoolsClear<CR>

" special stuff for markdown.
autocmd FileType mkd setlocal expandtab| setlocal tabstop=3| setlocal sw=3| setlocal tw=90
