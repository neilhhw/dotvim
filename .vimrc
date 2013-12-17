﻿set nocompatible

function! MySys()
  return "linux"
endfunction

if MySys() == "linux" || MySys() == "mac"
    set shell=bash
else
    "set shell=D:\MinGW\msys\1.0\msys.bat
endif

function! CurDir()
  let curdir = substitute(getcwd(), '/home/neilhhw', "~/", "g")
  return curdir
endfunction

"Set mapleader
let mapleader = ","
let g:mapleader = ","

set keymodel=startsel,stopsel
set selection=inclusive 
set ai
set magic
set sm
set cin
set nu
"set cinoptions={0,1s,t0,n-2,p2s,(03s,=.5s,>1s,=1s,:1s
set sw=4
set ts=4
set softtabstop=4
set et
set ru
filetype on

if has("eval")
    filetype plugin on
    filetype indent on
endif

"Set to auto read when a file is changed from the outside
set autoread

"Have the mouse enabled all the time:
if $TERM != "linux" && $TERM != "screen"
  set mouse=a           " except screen & SecureCRT's linux terminal
endif

"Fast saving
nmap <leader>w :w!<cr>
nmap <leader>f :find<cr>

nmap <leader>x :q!<CR>
"close current window
nmap <leader>z :close<CR>
"Do not use Ex-mode, use Q for formatting
map Q gq

map ^C ctrl + c

"Use the directory of the related buffer
set browsedir=buffer 

"Use register '*' for all y, d, c, p ops
set clipboard+=unnamed   

"None of these should be word dividers
set isk+=$,%,#   

"Raise a confirm dialog for changed buffer
set confirm 

"Platform dependent
if has("win32")        
    let $VIMRC    = $HOME.'/_vimrc'
    let $VIMDATA  = $HOME.'/_vimdata'
    let $VIMFILES = $VIM.'/vimfiles'
else
    let $VIMRC    = $HOME.'/.vimrc'
    let $VIMDATA  = $HOME.'/.vimdata'
    let $VIMFILES = $HOME.'/.vim'
endif

"Add this to rtp to satisfy getscript.vim
set rtp+=$VIMFILES
set rtp+=$VIMDATA

runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

"Fast sourcing and editing of the .vimrc
map <leader>s :source $VIMRC<cr>
map <leader>e :e! $VIMRC<cr>
au! BufWritePost [\._]vimrc source $VIMRC

"if you use vim in tty,
"'uxterm -cjk' or putty with option 'Treat CJK ambiguous characters as wide' on
if has("ambiwidth")
    set ambiwidth=double
endif

if has("gui_running")
    "set guioptions-=m
    "set guioptions-=T
    "set guioptions-=l
    "set guioptions-=L
    "set guioptions-=r
    "set guioptions-=R

    if MySys()=="win32"
        "start gvim maximized
        if has("autocmd")
            au GUIEnter * simalt ~x
        endif
    endif

    let psc_style='cool'
    colorscheme jellybeans
else
    set background=dark
    colorscheme desert256
endif

"Some nice mapping to switch syntax (useful if one mixes different languages in one file)
map <leader>1 :set syntax=c<cr>
map <leader>2 :set syntax=java<cr>
map <leader>3 :set syntax=python<cr>
map <leader>4 :set syntax=lua<cr>
map <leader>5 :set ft=javascript<cr>
map <leader>6 :set ft=xml<cr>
map <leader>$ :syntax sync fromstart<cr>

"Highlight current
if has("gui_running")   " highlight current line/column
    if v:version >= 700
        "set cursorline
        "hi CursorLine guibg=#333333
        "hi CursorColumn guibg=#333333
    endif
endif

"Favorite filetype
set ffs=unix,dos,mac

nmap <leader>fd :set ff=dos<cr>
nmap <leader>fu :set ff=unix<cr>

"by neil SET file encoding to make it fit in all platform for chinese
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
"Set font to Monaco 10pt
if has("win32")
    "set gfn=courier:h12
    set guifont=Monaco:h11
    "set encoding=utf-8
elseif MySys() == "mac"
    set gfn=Bitstream Vera Sans Mono:h14
    set nomacatsui
    set termencoding=macroman
elseif MySys() == "linux"
    set gfn=Monaco\ 11
    set encoding=utf-8
    "set fileencoding=utf-8
endif "save the coding error
"source $VIMRUNTIME/delmenu.vim
"source $VIMRUNTIME/menu.vim
syntax on
set backspace=start,eol,indent
if filereadable("./tags")
    set tags+=tags
endif
set hlsearch
"Remove the highlight searched phrases
map <silent> <leader><cr> :noh<cr>
set incsearch

"ino ( ()<esc>:let leavechar=")"<cr>i
"ino { {}<esc>:let leavechar="}"<cr>i
"ino $q ''<esc>:let leavechar="'"<cr>i
"ino $w ""<esc>:let leavechar='"'<cr>i
"imap <c-l> <esc>:exec "normal f" . leavechar<cr>a

"function ClosePair(char)
"if getline('.')[col('.') - 1] == a:char
"return "\<Right>"
"else
"return a:char
"endif
"endf

set wildmenu
"Type of file that will not in wildmenu
set wig=*.o,*.pyc,*.exe,*.obj,*.class

"Format the statusline
set statusline=
set statusline+=%f "path to the file in the buffer, relative to current directory
set statusline+=\ %h%1*%m%r%w%0* " flag
set statusline+=\ [%{strlen(&ft)?&ft:'none'}, " filetype
set statusline+=%{&encoding}, " encoding
set statusline+=%{&fileformat}] " file format
set statusline+=\ CWD:%r%{CurDir()}%h
set statusline+=\ Line:%l/%L       

"Smart way to move btw. window
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()

function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute "bdelete! ".l:currentBufNum
    endif
endfunction

"Actually, the tab does not switch buffers, but my arrow
"Bclose function ca be found in "Buffer related" section
map <leader>bd :Bclose<cr>
map <a-down> <leader>bd

"Use the arrows to something usefull
map <a-right> :bn<cr>
map <a-left> :bp<cr>

"Tab configuration
map <leader>tn :tabnew %<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
if has("usetab")
    set switchbuf=usetab
endif

"Switch to current dir
map <leader>d :cd %:p:h<cr>

map <leader>c "+y
vmap <leader>c "+y
nmap <leader>c "+y
map <leader>v <ESC>"+p
imap <leader>v <ESC>"+p
vmap <leader>v <ESC>"+p
nmap <leader>v <ESC>"+p

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Autocommand
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Ensure every file does syntax highlighting (full)
autocmd BufEnter * :syntax sync fromstart

"Having it auto maximize the screen
"autocmd GUIEnter * :simalt ~x --

"All the file under the directory are recognized as cpp files by vim
if has("win32")
    au BufEnter C:\MinGW\include\c++\* setf cpp
else
    au BufEnter /usr/include/c++/*   setf cpp
endif

"Comment for C like language
if has("autocmd")
    au BufNewFile,BufRead *.js,*.htc,*.c,*.tmpl,*.css,*.java ino $c /**<cr> **/<esc>O
endif

if has("autocmd")
    au BufNewFile,BufRead *.sdl,*.pr,*.sdt,*.spd,*.sst		setf sdl
endif

map <a-i> i <esc>r

fu! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endf
au BufWrite *.py :call DeleteTrailingWS()

"Enable folding, I find it very useful
set foldenable
set foldlevel=100

"Manual, marker, syntax, trying set foldcolumn=2         
set foldmethod=marker

if has("win32")
    set path=.,./../**
else
    set path=.,./../**,/usr/include/**,,
endif

set makeef=makeerror.err
map <leader>n :cn<cr>
map <leader>p :cp<cr>

"************************************************************************
"************************************************************************
"************************************************************************
"

let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
map <leader>tl :Tlist<cr>
nnoremap <silent> <F3> :Grep<CR>
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplSplitBelow=1

au BufEnter *.txt setlocal ft=txt
au BufEnter *.log setlocal ft=txt
let g:vimim_cloud_sogou=4


set completeopt=longest,menu

"Remap Tasklist
map <leader>ta <Plug>TaskList

"Git Interface
execute fugitive#statusline()

"************************************************************************
"************************************************************************

"------------------------------------------------------------------------
"------------------------------------------------------------------------
if has("eval") && has("autocmd")
    fun! <SID>abbrev_cpp()
        iabbrev <buffer> cci const_iterator
        iabbrev <buffer> ccl cla
        iabbrev <buffer> cco const
        iabbrev <buffer> cdb \bug
        iabbrev <buffer> cde \throw
        iabbrev <buffer> cdf /** \file<CR><CR>/<Up>
        iabbrev <buffer> cdg \ingroup
        iabbrev <buffer> cdn /** \namespace<CR><CR>/<Up>
        iabbrev <buffer> cdp \param
        iabbrev <buffer> cdt \test
        iabbrev <buffer> cdx /**<CR><CR>/<Up>
        iabbrev <buffer> cit iterator
        iabbrev <buffer> cns namespace
        iabbrev <buffer> cpr protected
        iabbrev <buffer> cpu public
        iabbrev <buffer> cpv private
        iabbrev <buffer> csl std::list
        iabbrev <buffer> csm std::map
        iabbrev <buffer> css std::string
        iabbrev <buffer> csv std::vector
        iabbrev <buffer> cty typedef
        iabbrev <buffer> cun using namespace
        iabbrev <buffer> cvi virtual
        iabbrev <buffer> #i #include
        iabbrev <buffer> #d #define
        "add by neilhhw to make it easier
        iabbrev <buffer> whil while() {<CR>}<ESC>kf(<ESC>
        iabbrev <buffer> mai int main() <CR>{<CR>return 0;<CR>}<ESC>2ko<ESC> 
        iabbrev <buffer> fo for() {<CR>}<ESC>kf(<ESC>
        iabbrev <buffer> ifi if() {<CR>}<ESC>kf(<ESC>
        iabbrev <buffer> ifel if() {<CR>}else {<CR>}<ESC>2k0f(
        iabbrev <buffer> ifeli if() {<CR>}else if {<CR>}else {<CR>}<ESC>3k0f(
    endfun

    fun! <SID>abbrev_java()
        iabbrev <buffer> #i import
        iabbrev <buffer> #p System.out.println
        iabbrev <buffer> #m public static void main(String[] args
    endfun

    fun! <SID>abbrev_python()
        iabbrev <buffer> #i import
        iabbrev <buffer> #p print
        iabbrev <buffer> #m if __name__=="__main":
    endfun

    augroup abbreviation
        autocmd!
        autocmd FileType cpp,c :call <SID>abbrev_cpp()
        autocmd FileType java :call <SID>abbrev_java()
        autocmd FileType python :call <SID>abbrev_python()
    augroup END
endif

"My information
iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>
iab xname Hongwei Hou
iab xmail neilhhw@gmail.com


"------------------------------------------------------------------------
"------------------------------------------------------------------------
