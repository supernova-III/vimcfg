call plug#begin()
    Plug 'scrooloose/nerdtree'
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'rhysd/vim-clang-format'
    Plug 'tacahiroy/ctrlp-funky'
    Plug 'morhetz/gruvbox'
    Plug 'mhartington/oceanic-next'
    Plug 'wadackel/vim-dogrun'
    Plug 'jsit/toast.vim'
    Plug 'Shatur/neovim-ayu'
    Plug 'bluz71/vim-nightfly-guicolors'
    Plug 'colepeters/spacemacs-theme.vim'
call plug#end()

let g:gruvbox_bold = 0
let g:gruvbox_contrast_dark='hard'
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

let g:nightflyItalics = 0
colorscheme spacemacs-theme
let c = synIDattr(hlID("Normal"), "bg")
exe 'hi WinSeparator guibg='.c . ' guifg='.c

"set guifont=Roboto\ Mono:h8
"set guifont=DinaRemasterII:h11
set guifont=Iosevka:h9
set smartindent
set tabstop=4
set splitright
set expandtab
set shiftwidth=4

windo set nowrap
set nowrap
set formatoptions=t
set cursorline
set noswapfile

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
nnoremap <M-F5> :bw!<CR>
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

