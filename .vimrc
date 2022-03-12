call plug#begin()
"Plug 'maksimr/vim-jsbeautify'

Plug 'puremourning/vimspector'
"https://stackoverflow.com/a/70206709
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'rhysd/vim-clang-format'
Plug 'davidhalter/jedi-vim'
Plug 'lambdalisue/vim-pyenv'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'KabbAmine/vCoolor.vim'

Plug 'franbach/miramare'

Plug 'preservim/NERDTree'

Plug 'heavenshell/vim-jsdoc', {
  \ 'for': ['javascript', 'javascript.jsx','typescript'],
  \ 'do': 'make install'
  \}

Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
"Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
"Plug 'ryanolsonx/vim-lsp-javascript'

" install fzf command
" export FZF_DEFAULT_COMMAND='rg --files --follow --hidden'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'Raimondi/delimitMate'

Plug 'prettier/vim-prettier', {
  \ 'branch': 'release/1.x',
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html', 'ejs'] }

Plug 'alvan/vim-closetag'
Plug 'vim-airline/vim-airline'

Plug 'bkad/CamelCaseMotion'
Plug 'tpope/vim-surround'
Plug 'terryma/vim-multiple-cursors'
"Plug 'nathanaelkane/vim-indent-guides'
Plug 'Yggdroot/indentLine'
Plug 'tmhedberg/matchit'
" install ctags command
Plug 'vim-scripts/taglist.vim'
"Plug 'frazrepo/vim-rainbow'
Plug 'preservim/nerdcommenter'
" instal ack command
Plug 'mileszs/ack.vim'
Plug 'OmniSharp/omnisharp-vim'
Plug 'OrangeT/vim-csharp'
Plug 'idbrii/vim-unityengine'
Plug 'vim-syntastic/syntastic'
"Plug '907th/vim-auto-save'

call plug#end()

"set rtp+=/usr/local/opt/fzf


let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDToggleCheckAllLines = 1

let g:rainbow_active = 0
let g:rainbow_ctermfgs = ['lightblue', 'lightgreen', 'yellow', 'green', 'magenta']

"let g:indent_guides_enable_on_vim_startup = 0
"hi IndentGuidesOdd  ctermbg=black
"hi IndentGuidesEven ctermbg=darkgrey
"

let g:asyncomplete_auto_completeopt = 0
set completeopt=menuone,noinsert,noselect,preview

set number
:highlight LineNr ctermfg=grey

set shiftwidth=2
set softtabstop=2
set tabstop=2

function! Preserve(command)
  " Save the last search.
  let search = @/

  " Save the current cursor position.
  let cursor_position = getpos('.')

  " Save the current window position.
  normal! H
  let window_position = getpos('.')
  call setpos('.', cursor_position)

  " Execute the command.
  execute a:command

  " Restore the last search.
  let @/ = search

  " Restore the previous window position.
  call setpos('.', window_position)
  normal! zt

  " Restore the previous cursor position.
  call setpos('.', cursor_position)
endfunction


" Re-indent the whole buffer.
function! Indent()
  call Preserve('normal gg=G')
endfunction

" for html/rb files, 2 spaces
autocmd Filetype javascript,json,jsx,php,ejs setlocal ts=2 sw=2 expandtab
autocmd  BufWritePost *.js,*.ts,*.jsx Prettier
autocmd  BufWritePost * NERDTreeRefreshRoot
autocmd  BufWritePre *.css,*.html,*.php call Indent()

autocmd Filetype html setlocal ts=2 sw=2 expandtab
au FileType html let b:delimitMate_autoclose = 0
autocmd Filetype ruby setlocal ts=2 sw=2 expandtab
autocmd Filetype cs setlocal ts=4 sw=4 expandtab
autocmd BufWritePost *.cs OmniSharpCodeFormat
autocmd FileType cs colorscheme miramare

" for python files, 4 spaces
autocmd Filetype python setlocal ts=4 sw=4 expandtab
autocmd Filetype python SyntasticToggleMode


let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1

augroup javascript_folding
	au!
	au FileType javascript setlocal foldmethod=syntax
augroup END

set conceallevel=0

let g:jsx_ext_required = 0
let g:jsx_pragma_required = 0
"let g:ale_fixers = {
"			\ '*': ['remove_trailing_lines', 'trim_whitespace'],
"			\ 'javascript': [],
"			\}
"     \ 'cs': ['OmniSharp']

" let b:ale_fixers = ['prettier', 'eslint']

let g:ale_fix_on_save = 0
let g:ale_completion_enabled = 0
let g:ale_completion_tsserver_autoimport = 0
"set omnifunc=ale#completion#OmniFunc
let g:ale_sign_error = "◉"
let g:ale_sign_warning = "◉"
highlight ALEErrorSign ctermfg=9 ctermbg=15 guifg=#C30500 guibg=#F5F5F5
highlight ALEWarningSign ctermfg=11 ctermbg=15 guifg=#ED6237 guibg=#F5F5F5
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
" You can disable this option too
" " if you don't want linters to run on opening a file
let g:ale_lint_on_enter = 0



" TextEdit might fail if hidden is not set.
set hidden

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif



if executable('pyls')
    " pip install python-language-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'allowlist': ['python'],
        \ })
endif
if jedi#init_python()
  function! s:jedi_auto_force_py_version() abort
    let g:jedi#force_py_version = pyenv#python#get_internal_major_version()
  endfunction
  augroup vim-pyenv-custom-augroup
    autocmd! *
    autocmd User vim-pyenv-activate-post   call s:jedi_auto_force_py_version()
    autocmd User vim-pyenv-deactivate-post call s:jedi_auto_force_py_version()
  augroup END
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <Plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <Plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)

    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

let g:lsp_signs_enabled = 1         " enable signs
let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode

let g:lsp_signs_error = {'text': '◉'}
let g:lsp_signs_warning = {'text': '◉'}
set nofoldenable

let g:prettier#autoformat = 0
let g:prettier#autoformat_require_pragma = 1


nnoremap <F5> :buffers<CR>:buffer<Space>
nnoremap <C-X><C-B> :buffers<CR>:buffer<Space>
" Buffers - explore/next/previous: Alt-F11, F12, Shift-F12.
nnoremap <S-B> :bp<CR>
nnoremap <S-N> :bn<CR>
nnoremap <C-K> :bd<CR>


set statusline=2

let g:camelchar = "A-Z"
" Also stop on numbers.
let g:camelchar = "A-Z0-9"

map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
map <silent> ge <Plug>CamelCaseMotion_ge
sunmap w
sunmap b
sunmap e
sunmap ge




let g:indentLine_enabled = 1
"let g:indentLine_setColors = 0
"let g:indentLine_setConceal = 0
"let g:indentLine_concealcursor = 'inc'
let g:indentLine_conceallevel = 1
let g:indentLine_color_term = 8
"let g:indentLine_char = '.'
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

au BufRead,BufEnter,BufNewFile * IndentLinesReset

" yank to clipboard
if has("clipboard")
  set clipboard=unnamed " copy to the system clipboard

  if has("unnamedplus") " X11 support
    set clipboard+=unnamedplus
  endif
endif

if !has('gui_running')
  map "in Insert mode, type Ctrl+v Alt+n here" <A-n>
endif

let g:multi_cursor_use_default_mapping=0

" Default mapping
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<C-a>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<C-a>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'
let g:multi_cursor_start_key           = 'g<C-n>'

set noequalalways
"winsize 170 55
"
"set shellcmdflag=-ic
let g:OmniSharp_server_stdio = 1
let g:OmniSharp_server_use_mono = 1
set completeopt-=preview


let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.php,*.jsx,*.js,*.ejs"
let g:closetag_emptyTags_caseSensitive = 1

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_cs_checkers = ['code_checker']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1

" see :h syntastic-loclist-callback
function! SyntasticCheckHook(errors)
    if !empty(a:errors)
        let g:syntastic_loc_list_height = min([len(a:errors), 5])
    endif
endfunction

let g:auto_save = 0
let g:syntastic_mode_map = { 'passive_filetypes': ['python'] }
"colorscheme odyssey
colorscheme miramare
au BufNewFile,BufRead *.ejs set filetype=html

set guioptions -=T
set guioptions -=m
set guioptions -=r
set ttyfast
set mouse=a
set ttymouse=xterm2


nnoremap <C-F> :Files<CR>
nnoremap <C-X><C-F> :GitFiles<CR>
nnoremap <C-L> :CocDiagnostics<CR>

if &term =~ "xterm\\|rxvt"
  " use an orange cursor in insert mode
  let &t_SI = "\<Esc>]12;orange\x7"
  " use a red cursor otherwise
  let &t_EI = "\<Esc>]12;red\x7"
  silent !echo -ne "\033]12;red\007"
  " reset cursor when vim exits
  autocmd VimLeave * silent !echo -ne "\033]112\007"
  " use \003]12;gray\007 for gnome-terminal
endif

let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" Trigger configuration. You need to change this to something else than <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<C-.>"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
let g:OmniSharp_loglevel = 'debug'


let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"
let g:html_indent_inctags = "html,body,head"


" cpp
" https://chmanie.com/post/2020/07/17/modern-c-development-in-neovim/
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:syntastic_cpp_checkers = ['cpplint']
let g:syntastic_c_checkers = ['cpplint']
let g:syntastic_cpp_cpplint_exec = 'cpplint'
" The following two lines are optional. Configure it to your liking!
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:clang_format#auto_format = 1
nnoremap <Leader>f :<C-u>ClangFormat<CR>
let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
            \ "AllowShortIfStatementsOnASingleLine" : "true",
            \ "AlwaysBreakTemplateDeclarations" : "true",
						\ "ShortNamespaceLines": 0,
						\ "NamespaceIndentation": "All",
						\ "Standard" : "c++17"}

" debug
let g:vimspector_enable_mappings = 'HUMAN'
"packadd! vimspector
