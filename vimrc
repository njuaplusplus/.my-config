set nocompatible               " be iMproved
filetype off                   " required!

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" My Bundles here:
"
" original repos on github
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'plasticboy/vim-markdown'
Plugin 'altercation/vim-colors-solarized'
" for statline, like powerline
" Plugin 'scrooloose/vim-statline'
" Plugin 'bling/vim-airline'
Plugin 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'Valloric/MatchTagAlways'
" Plugin 'gregsexton/MatchTag'
Plugin 'chrisbra/Colorizer'
Plugin 'KabbAmine/vCoolor.vim'
Plugin 'vim-latex/vim-latex'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'rizzatti/dash.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

set nu
set backspace=2
set autoindent
set cindent
set ruler
set laststatus=2      " Always display the statusline in all windows
set noshowmode        " Hide the default mode text (e.g. -- INSERT -- below the statusline)
set showcmd
set bg=dark
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
set smarttab
set hlsearch
set list
set listchars=tab:>-,trail:-
set ignorecase              "检索时忽略大小写
set smartcase
" set mouse=n
set tabpagemax=150
syntax enable
syntax on

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_tex_chktex_args = '-n 1'

set t_Co=256         " Explicitly tell Vim that the terminal support 256 colors
" Using vundle to add powerline only in vim
" python from powerline.vim import setup as powerline_setup
" python powerline_setup()
" python del powerline_setup

nmap tt :%s/\t/    /g<CR>

set fileencodings=utf-8
set termencoding=utf-8
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,ucs-bom,gbk,cp936,gb2312,gb18030
let &termencoding=&encoding

filetype on
" done by the plasticboy/vim-markdown
au BufRead,BufNewFile *.md set filetype=markdown
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java,*.py exec ":call SetTitle()"
""定义函数SetTitle，自动插入文件头
func SetTitle()
    "如果文件类型为.sh文件
    if &filetype == 'sh'
        call setline(1,"\#!/bin/bash")
        call append(line("."), "")
        elseif &filetype == 'python'
        call setline(1,"#!/usr/bin/env python")
        call append(line("."),"# coding=utf-8")
        call append(line(".")+1, "")
    "    elseif &filetype == 'mkd'
    "        call setline(1,"<head><meta charset=\"UTF-8\"></head>")
    else 
        call setline(1, "/*************************************************************************")
        call append(line("."), "    > File Name: ".expand("%"))
        call append(line(".")+1, "    > Author: Shengwei An")
        call append(line(".")+2, "    > Mail: njuaplusplus@gmail.com")
        call append(line(".")+3, "    > Created Time: ".strftime("%c"))
        call append(line(".")+4, " ************************************************************************/")
        call append(line(".")+5, "")
    endif
    if &filetype == 'cpp'
        call append(line(".")+6, "#include<iostream>")
        call append(line(".")+7, "using namespace std;")
        call append(line(".")+8, "")
    endif
    if &filetype == 'c'
        call append(line(".")+6, "#include<stdio.h>")
        call append(line(".")+7, "")
    endif
"    if &filetype == 'java'
"        call append(line(".")+6,"public class ".expand("%"))
"        call append(line(".")+7,"")
"    endif
"新建文件后，自动定位到文件末尾
endfunc 
autocmd BufNewFile * normal G
filetype plugin indent on

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" for solarized, if you do use the custom terminal colors rather than the
" solarized palette for terminal
" let g:solarized_termcolors=256
let g:solarized_termtrans = 1
colorscheme solarized

" for plugin 'Valloric/MatchTagAlways'
let g:mta_use_matchparen_group = 0
let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'jinja' : 1,
    \ 'jsp' : 1,
    \ 'htmldjango' : 1,
    \}

" for plugin 'scrooloose/nerdtree'
" autocmd VimEnter * NERDTree

map <C-h> :vert: res-5<CR>
map <C-l> :vert: res+5<CR>
map <C-j> :res-5 <CR>
map <C-k> :res+5 <CR>

" Change default target to pdf, if not dvi is used
let g:Tex_DefaultTargetFormat = 'pdf'

" Setup the compile rule for pdf to use pdflatex with synctex enabled
let g:Tex_CompileRule_pdf = 'pdflatex -synctex=1 --interaction=nonstopmode $*'

" PDF display rule
let g:Tex_ViewRule_pdf = 'open -a Skim'

map ,ll <leader>ll

" ,ls to forward search
map ,ls :w<CR>:silent !/Applications/Skim.app/Contents/SharedSupport/displayline -r <C-r>=line('.')<CR> %<.pdf %<CR><CR>

" ,lv to display pdf
map ,lv <leader>lv

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" disable ctrl+a which increases the number
" https://stackoverflow.com/questions/36601789/disable-for-good-vims-number-increment-that-is-mapped-to-ctrl-a
map <C-a> <Nop>

function Py2()
  let g:syntastic_python_python_exec = '/usr/bin/python'
endfunction

function Py3()
  let g:syntastic_python_python_exec = '/usr/bin/python3'
endfunction

" call Py3()   " default to Py3 because I try to use it when possible
