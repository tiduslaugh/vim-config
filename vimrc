set nocompatible               " disable vi compatibility mode
set backspace=indent,eol,start " make backspace behave properly by default
set autoindent                 " autoindent files by default
set hidden                     " hide when switching buffers
syntax on                      " syntax highlighting on
set background=dark
set number                     " enable line numbers
set encoding=utf-8             " no, _I_ tf-8
set shiftwidth=4               " autoindent tabs are 4 spaces
let &softtabstop = &shiftwidth " same for editing operations 
set expandtab                  " and they are spaces
set tabstop=4                  " same for actual tabs

set incsearch

set wildmenu                   " status bar helps out with autocomplete
set wildignore+=*.swap,.viminfo
let mapleader = "\<Space>"     " leader key for custom mappings

set laststatus=2
set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]

function! StripTrailingWhitespace()
  if !&binary && &filetype != 'diff'
    normal mz
    normal Hmy
    %s/\s\+$//e
    normal 'yz<CR>
    normal `z
  endif
endfunction

set path=.,**
" add additional files to the arglist
" noremap <leader>a :argadd <c-r>=fnameescape(expand('%:p:h'))<cr>/*<C-d>
noremap <leader>b :b <C-d>
" bring up an edit command that can search all subdirs
noremap <leader>e :e <C-R>=expand('%:p:h') . '/'<CR>
noremap <leader>f :find *
" noremap <leader>i :Ilist<space>
noremap <leader>j :tjump /
noremap <leader>s :call StripTrailingWhitespace()<cr>
noremap <leader>q :b#<cr>

nnoremap <leader>i i_<Esc>r
nnoremap <leader>a a_<Esc>r

" set guifont=Inconsolata-dz_for_Powerline:h10
if has('gui_running')
  set guioptions-=T  " no toolbar
  " set lines=60 columns=108 linespace=0
  if has('gui_win32')
    if hostname() == 'MALEX-PC'
      set guifont=Source\ Code\ Pro:h12:cANSI
    else
      set guifont=Mononoki:h14:cANSI
    end
  else
    set guifont=Mononoki\ 12
  endif
endif
filetype plugin indent on

let g:html_indent_inctags = "html,body,head,tbody" 
" let g:rainbow_active=1

execute pathogen#infect()
if has("win32") || has("win16")
    let base16colorspace="256"
    set t_Co=256
    set background=dark
    colorscheme base16-eighties
else
    let os = substitute(system('uname'), "\n", "", "")
    if os == "FreeBSD"
        colorscheme desert
    else
        let base16colorspace=256
        set t_Co=256
        set background=dark
        colorscheme base16-eighties
    end
end
let g:python_highlight_all=1

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
            \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
            \gvy/<C-R><C-R>=substitute(
            \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
            \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
            \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
            \gvy?<C-R><C-R>=substitute(
            \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
            \gV:call setreg('"', old_reg, old_regtype)<CR>
