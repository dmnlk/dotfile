" neobundle
set nocompatible               " Be iMproved
filetype off                   " Required!
if has('vim_starting')
  set runtimepath+=~/.vim/neobundle.vim
  call neobundle#begin(expand('~/.vim/bundle/'))
  NeoBundleFetch 'Shougo/neobundle.vim'
  call neobundle#end()
endif
NeoBundle 'Shougo/neocomplcache.git'
NeoBundle 'Shougo/neosnippet.git'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/unite.vim.git'
NeoBundle 'Shougo/vimshell.git'
NeoBundle 'derekwyatt/vim-scala.git'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'szw/vim-tags'
NeoBundle 'tomasr/molokai.git'
NeoBundle 'vim-scripts/errormarker.vim.git'
NeoBundle 'wincent/Command-T'
NeoBundle 'scrooloose/syntastic.git'
NeoBundle 'justmao945/vim-clang'
filetype plugin indent on     " Required!
"   Installation check.
if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
        \ string(neobundle#get_not_installed_bundle_names())
  echomsg 'Please execute ":NeoBundleInstall" command.'
endif

" display
set showmatch
set number
set ruler
set cursorline
" indent
set smartindent
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
" etc
set smartcase
set history=50
syntax on

" colorschehme
colorscheme molokai
let g:molokai_original=1

" neocomplcache
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'scala' : $HOME . '/.vim/dict/scala.dict',
    \ }

" neosnippet
"   Plugin key-mappings.
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
"   SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
"   For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
let g:neosnippet#snippets_directory='~/.vim/snippets'

" vimsehll
let g:vimshell_interactive_update_time = 10
let g:vimshell_prompt = $USER."% "
"vimshell map
nmap vs :VimShell<CR>
nmap vp :VimShellPop<CR>

" make
autocmd FileType scala :compiler sbt
autocmd QuickFixCmdPost make if len(getqflist()) != 0 | copen | endif

" marker
let g:errormarker_errortext     = '!!'
let g:errormarker_warningtext   = '??'
let g:errormarker_errorgroup    = 'Error'
let g:errormarker_warninggroup  = 'ToDo'

" TagBar
nmap <F8> :TagbarToggle<CR>

" NERDTree
nmap <silent> <C-e> :NERDTreeToggle<CR>
vmap <silent> <C-e> <Esc> :NERDTreeToggle<CR>
omap <silent> <C-e> :NERDTreeToggle<CR>
imap <silent> <C-e> <Esc> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let g:NERDTreeShowHidden=1

" vim-tags
nnoremap <C-]> g<C-]>

" indent-guides
let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 1



python from powerline.vim import setup as powerline_setup  
python powerline_setup()  
python del powerline_setup  

set laststatus=2 " Always display the statusline in all windows
set showtabline=2 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

set backupskip=/tmp/*,/private/tmp/*

let g:neocomplete#enable_at_startup = 1
if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_overwrite_completefunc = 1
let g:neocomplete#force_omni_input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#force_omni_input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

let g:clang_auto = 0
let g:clang_complete_auto = 0
let g:clang_auto_select = 0
let g:clang_use_library = 1

let g:clang_c_completeopt   = 'menuone'
let g:clang_cpp_completeopt = 'menuone'

let g:clang_c_options = '-std=c11'
let g:clang_cpp_options = '-std=c++1z -stdlib=libc++ --pedantic-errors'
