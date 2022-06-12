call plug#begin()
    Plug 'scrooloose/nerdtree'
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'rhysd/vim-clang-format'
    Plug 'tacahiroy/ctrlp-funky'
    Plug 'morhetz/gruvbox'
    Plug 'rakr/vim-one'
    Plug 'mhartington/oceanic-next'
    Plug 'wadackel/vim-dogrun'
call plug#end()

set guifont=Roboto\ Mono:h8.5
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
colorscheme gruvbox

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

nnoremap <C-b> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
nnoremap <M-p> :CtrlPFunky<CR>
nnoremap <F5> :vsplit term://cmake --build build<CR>
nnoremap <M-F5> :+q<CR>
nnoremap <A-F4> :qa<CR>

fu! OpenCompanion(n)
    let cur_ext = expand("%:e")
    if index(["hh", "h", "hpp"], cur_ext) >= 0
        let p = expand("%:r")

        if filereadable(p . ".cc")
            let p = p . ".cc"
        elseif filereadable(p . ".cpp")
            let p = p . ".cpp"
        elseif filereadable(p . ".cxx")
            let p = p . ".cxx"
        elseif filereadable(p . ".c")
            let p = p . ".c"
        endif

    elseif index(["cc", "cpp", "cxx", "c"], cur_ext) >= 0
        let p = expand("%:r")

        if filereadable(p . ".h")
            let p = p . ".h"
        elseif filereadable(p . ".hh")
            let p = p . ".hh"
        elseif filereadable(p . ".hpp")
            let p = p . ".hpp"
        endif
    else
        return
    endif

    if a:n == 0
        execute "vsplit" p
    else
        execute "e" p
    endif
endfunction

nnoremap <F3> :call OpenCompanion(0)<CR>
nnoremap <A-F3> :call OpenCompanion(1)<CR>

" win32 binds
if has('win32')
    nnoremap <S-T> :vnew term://cmd<CR>
    nnoremap <F4> :!start remedybg project/debug.rdbg<CR><CR>
endif

" default formatting
autocmd FileType c,cpp,cc,hh,hpp,h,cxx ClangFormatAutoEnable
if !filereadable(".clang-format")
    autocmd FileType c,cpp,cc,hh,hpp,h,cxx ClangFormatAutoDisable
endif

let g:ctrlp_user_command = ['.git/', 'git ls-files --cached --others  --exclude-standard %s']

