set nocompatible 

set guioptions=

set incsearch
set smartcase
set termencoding=utf8
set encoding=utf8
set autoindent
set smartindent

set expandtab
set tabstop=4
set shiftwidth=4

au BufRead,BufNewFile Makefile* set noexpandtab

set showmatch

colorscheme desert

set timeoutlen=50

set t_Co=256
set guifont=Courier\ New:h10
set splitright
set splitbelow

set nu rnu
set noswapfile
set nowrap

map <C-b> :NERDTreeToggle<CR>
map <C-n> :NERDTreeFocus<CR>

map <F5> :VimProjectBuild<CR>
map <C-F5> :VimProjectBuildDebug<CR>
map <F7> :VimProjectCompileCurrent %:.<CR>
map <C-L> :VimProjectLoad<CR>
map <F2> :cclose<CR>




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

nnoremap <S-h> :call ToggleHiddenAll()<CR>
" disable beep
set vb t_vb=
" disable visual beep
set t_vb=
set belloff=all
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
