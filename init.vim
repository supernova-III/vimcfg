call plug#begin()
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'rhysd/vim-clang-format'
Plug 'tacahiroy/ctrlp-funky'
Plug 'morhetz/gruvbox'
Plug 'rakr/vim-one'
Plug 'skywind3000/asyncrun.vim'
Plug 'mhartington/oceanic-next'
Plug 'ajmwagar/vim-deus'
Plug 'wadackel/vim-dogrun'
Plug 'liuchengxu/space-vim-dark'
call plug#end()

set number
"set guifont=Hack:h8
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
colorscheme dogrun

if isdirectory('src/')
    set path+=src
endif

if isdirectory('source/')
    set path+=souce
endif

if isdirectory('Source/')
    set path+=Souce
endif

" basic VIM autocompletion for Vulkan API
if isdirectory($VULKAN_SDK."/include/")
    set path+=$VULKAN_SDK/include
    badd $VULKAN_SDK/include/vulkan/vulkan_core.h
    if has('win32')
        badd $VULKAN_SDK/include/vulkan/vulkan_win32.h
    elseif has('linux')
        badd $VULKAN_SDK/include/vulkan/vulkan_xlib.h
        badd $VULKAN_SDK/include/vulkan/vulkan_xlib_xrandr.h
        badd $VULKAN_SDK/include/vulkan/vulkan_xlib_wayland.h
    endif
endif

autocmd FileType c,cpp,cc,hh,hpp,h,cxx ClangFormatAutoEnable
nnoremap <C-b> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
nnoremap <M-p> :CtrlPFunky<CR>
nnoremap <F2>  :w $MYVIMRC<CR>:so $MYVIMRC<CR>
nnoremap <M-F2>  :so $MYVIMRC<CR>
nnoremap <F5> :AsyncRun -mode=term -cwd=build -pos=right -focus=0 cmake --build .<CR>
nnoremap <M-F5> :+q<CR>

fu! OpenCompanion()
    let cur_ext = expand("%:e")
    if cur_ext == "hh" || cur_ext == "h"
        let p = expand("%:r")

        if filereadable(p . ".cc")
            let p = p . ".cc"
        elseif filereadable(p . ".cpp")
            let p = p . ".cpp"
        elseif filereadable(p . ".cxx")
            let p = p . ".cxx"
        endif

        execute "vsplit" p
    elseif cur_ext == "cc" || cur_ext == "cpp" || cur_ext == "cxx"
        let p = expand("%:r")

        if filereadable(p . ".h")
            let p = p . ".h"
        elseif filereadable(p . ".hh")
            let p = p . ".hh"
        endif

        execute "vsplit" p
    endif

endfunction

nnoremap <F3> :call OpenCompanion()<CR>
nnoremap <C-F2> :e $MYVIMRC<CR>

" win32 binds
if has('win32')
    nnoremap <S-T> :vs<CR> :terminal<CR>
    nnoremap <F4> :!start remedybg project/debug.rdbg<CR><CR>
endif



let g:ctrlp_user_command = ['.git/', 'git ls-files --cached --others  --exclude-standard %s']

