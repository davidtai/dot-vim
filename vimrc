set nocompatible
filetype indent plugin on | syntax on

let options = {
    \ 'addons': [
        \ 'github:zeekay/vice-beautify',
        \ 'github:zeekay/vice-colorful',
        \ 'github:zeekay/vice-ctrlp',
        \ 'github:zeekay/vice-delimitmate',
        \ 'github:zeekay/vice-git',
        \ 'github:zeekay/vice-polyglot',
        \ 'github:zeekay/vice-neocompletion',
        \ 'github:zeekay/vice-standard-issue',
        \ 'github:zeekay/vice-syntastic',
        \ 'github:zeekay/vice-tagbar',
        \ 'github:zeekay/vice-undo',
        \ 'github:zeekay/vice-nerdtree',
        \ 'github:zeekay/vice-startify',
        \ 'github:zeekay/vice-lightline',
        \ 'github:zeekay/vim-cake',
        \ 'github:terryma/vim-multiple-cursors',
        \ 'github:tpope/vim-vinegar',
    \ ],
    \ 'commands': {
        \ 'GitGutterToggle':    ['github:airblade/vim-gitgutter'],
        \ 'IndentGuidesToggle': ['github:nathanaelkane/vim-indent-guides'],
        \ 'Sum':                ['github:zeekay/visSum.vim'],
        \ 'Tabularize':         ['github:godlygeek/tabular'],
    \ },
    \ 'standard_issue': {
        \ 'transparency': 0
    \ }
\ }

if has('mac') && version > 702
    let options.addons += ['github:Shougo/vimproc', 'github:Shougo/vimshell']
    let options.neocompletion = {
        \ 'enable_clang_complete': 1,
        \ 'enable_jedi': 1,
        \ 'enable_necoghc': 1,
        \ 'enable_tern': 1,
    \ }
endif

let &rtp.=','.expand('~/.vim/addons/vice')
call vice#Initialize(options)

" Prevent cursor from moving when leaving insert mode.
inoremap <Esc> <Esc>`^

" Mappings.
nnoremap <leader>gg :GitGutterToggle<cr>
nnoremap <leader>ig :IndentGuidesToggle<cr>
nnoremap <leader>m :set mouse=a<cr>
nnoremap <leader>q :q<cr>
nnoremap Q ZQ
nnoremap J <c-d>
nnoremap K <c-u>
vnoremap J <c-d>
vnoremap K <c-u>
inoremap <c-u> <c-o>dd
nnoremap ; :

" Abbreviations
cabbrev ack <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Ack' : 'ack')<CR>
cabbrev shell <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'VimShell' : 'shell')<CR>
cabbrev shelli <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'VimShellInteractive' : 'shelli')<CR>
cabbrev sudowrite Sudowrite
cabbrev sudoedit Sudoedit
cabbrev sw Sudowrite
cabbrev se Sudoedit

if has('gui_running')
    color base16-mocha
    set background=dark
else
    set nolazyredraw
    set ttyfast

    if $VIM_LIGHT_BG
        set background=light
        colorscheme solarized
        hi Normal ctermbg=15
        let g:lightline['colorscheme'] = 'solarized'
    else
       color hybrid
       hi Normal ctermbg=235 ctermfg=254
       let g:indent_guides_auto_colors = 0
       hi IndentGuidesOdd  ctermbg=236
       hi IndentGuidesEven ctermbg=236
    endif
endif

hi link coffeeFunction Function
hi link coffeeMethod Function
hi link coffeeObjAssign Statement

let g:python_highlight_all = 1
let g:gitgutter_enabled = 0
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2

" Prefer to use my local copies of each go binary
let g:go_disable_autoinstall = 1

if exists('$GOPATH')
    let gotools = {
        \ 'gocode':    'github.com/nsf/gocode',
        \ 'goimports': 'github.com/bradfitz/goimports',
        \ 'godef':     'code.google.com/p/rog-go/exp/cmd/godef',
        \ 'oracle':    'code.google.com/p/go.tools/oracle',
        \ 'golint':    'github.com/golang/lint',
        \ 'errcheck':  'github.com/kisielk/errcheck',
    \ }

    " Install all deps into ~/go
    let GOPATH = expand('~/go')

	for [key, value] in items(gotools)
        if !executable(key)
            exe '!go get -u '.value
        endif
        exe "let g:go_".key."_bin='".GOPATH."/bin/".key."'"
    endfor
endif
