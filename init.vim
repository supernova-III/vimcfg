call plug#begin()
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'rhysd/vim-clang-format'
Plug 'tacahiroy/ctrlp-funky'
Plug 'morhetz/gruvbox'
Plug 'rakr/vim-one'
Plug 'skywind3000/asyncrun.vim'
Plug 'mhartington/oceanic-next'
call plug#end()

set number
"set guifont=Hack:h8
"set guifont=Liberation\ Mono:h8
"set guifont=Cascadia\ Mono:h9
"set guifont=Source\ Code\ Pro:h9
"set guifont=Consolas:h9
set guifont=JetBrains\ Mono\ NL:h8
set relativenumber
set smartindent
set tabstop=4
set splitright
set expandtab
set shiftwidth=4

windo set nowrap
set nowrap
set formatoptions=t
set cursorline
set background=dark
set noswapfile
colorscheme OceanicNext

if isdirectory('src/')
    set path+=src
endif

if isdirectory('source/')
    set path+=souce
endif

if isdirectory('Source/')
    set path+=Souce
endif

if isdirectory($VULKAN_SDK."/include/")
    set path+=$VULKAN_SDK/include
endif

autocmd FileType c,cpp,cc,hh,hpp,h,cxx ClangFormatAutoEnable
nnoremap <C-b> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
nnoremap <M-p> :CtrlPFunky<CR>
nnoremap <F2>  :w $MYVIMRC<CR>:so $MYVIMRC<CR>
nnoremap <M-F2>  :so $MYVIMRC<CR>
nnoremap <F5> :AsyncRun -mode=term -cwd=build -pos=right -focus=0 cmake --build .<CR>
nnoremap <M-F5> :+q<CR>
let g:ctrlp_user_command = ['.git/', 'git ls-files --cached --others  --exclude-standard %s']

