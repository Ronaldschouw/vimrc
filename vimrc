" Source original vimrc by Bram Molenaar -------------------------------------
" Type :version to see which configuration files are used
if filereadable(expand("$HOME/.vim/defaults.vim"))
  source $HOME/.vim/defaults.vim
endif

" Note: expand: zo/zr / close: zc/zm

" DEFAULT OPTIONS {{{1 -------------------------------------------------------
" unset visual mouse
set mouse=

" spellchecking (stty -ixon)
set spl=en_us "spelllang
nnoremap <silent> <C-s> :set spell!<CR>

" disable swapfile
set noswapfile
" change viminfo location
set viminfo ='100,n$HOME/.vim/.viminfo

" set toggle paste mode
set pastetoggle=<C-p>

" invert split position
set splitbelow
set splitright

" insert tab as spaces
set tabstop=2
set expandtab

" ignore case while searching (smart)
set ic smartcase
" highlight searches (note: :nohl)
set hlsearch

" automatic wordwrap
set wrap
set textwidth=79
" fo will be overridden, :verb set fo, to fix:
" https://vi.stackexchange.com/questions/9366/set-formatoptions-in-vimrc-is-being-ignored
autocmd FileType * set fo+=t fo-=o

" netrw defaults
let g:netrw_liststyle = 3
let g:netrw_banner    = 0

" allow vim modeline ---------------------------------------------------------
" # vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
set modeline
" }}}1

" COLORSCHEME {{{1 -----------------------------------------------------------
set t_Co=256 " prevent warning when loading colorscheme
"colorscheme draxor
colorscheme xoria256
if expand("$XAUTHORITY") == '$XAUTHORITY'
  " some changes for the statusline
  hi StatusLine ctermbg=12  ctermfg=2
  hi WildMenu   ctermbg=1   ctermfg=15
endif
" }}}1

" VISUALDIFF {{{1 ------------------------------------------------------------
" visual diff against original
" :Zdiff show dif
" :Xdiff close diff
if !exists(":Zdiff")
  command Zdiff vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
                \ | wincmd p | diffthis
endif
if !exists(":Xdiff")
  command Xdiff wincmd o | diffoff
endif
" }}}1

" VISUALINDENT {{{1 ----------------------------------------------------------
" make tab in v mode work like I think it should (keep highlighting)
set shiftwidth=2 "tab indentation
vmap <tab> >gv
vmap <s-tab> <gv
vnoremap < <gv
vnoremap > >gv
" }}}1

" BASH FOLDING {{{1 ----------------------------------------------------------
" https://stackoverflow.com/questions/35064131/how-do-i-get-code-folding-in-vim-for-shell-scripts-working
" change number below to your likings
au FileType sh let g:sh_fold_enabled=3
au FileType sh let g:is_bash=1
au FileType sh set foldmethod=syntax
syntax enable
" }}}1

" LINENUMBERS {{{1 -----------------------------------------------------------
" line numbering (autotoggle)
" https://jeffkreeftmeijer.com/vim-number/
set nu
set rnu
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set number relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set number norelativenumber
augroup END
command  Nonu set nonumber norelativenumber
" }}}1

" AUTOCOMPLETION {{{1 --------------------------------------------------------
" python autocompletion
" ~$ sudo apt install vim-python-jedi
" ~$ vim-addons install python-jedi
" (manually resolve any errors)

" autocompletion (always on) -------------------------------------------------
" 1) http://vim.wikia.com/wiki/Autocomplete_with_TAB_when_typing_words
" 2) http://vim.wikia.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE
function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    let l:ret = "\<C-N>"
    let l:ret = pumvisible() ? ret :
              \ (&filetype == "python") ? "\<C-x>\<C-o>" : ret
    return ret
  else
    return "\<Tab>"
  endif
endfunction
inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
" }}}1

" TABBING {{{1 ---------------------------------------------------------------
" easy tab stuff
nnoremap <silent> <C-Left> :tabprevious<CR>
nnoremap <silent> <C-Right> :tabnext<CR>
" white space below is required!
nnoremap <C-t> :tabnew 
"ball: one window for each buffer | tabonly: close all other tabs
nnoremap <C-t>q <Esc>:ball \| :tabonly<CR>
" }}}1

" WINDOW SWITCHING {{{1 ------------------------------------------------------
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" }}}1

" FILETYPES {{{1 -------------------------------------------------------------
" thanks to https://gitlab.com/akisys
augroup ft_haproxy " {{{2
  au!
  au BufRead,BufNewFile haproxy* set ft=haproxy
augroup END
" }}}2

augroup ft_yaml " {{{2
  if exists("b:did_indent")
    finish
  endif
  "runtime! indent/ruby.vim
  "unlet! b:did_indent
  let b:did_indent = 1
  setlocal autoindent sw=2 et
  setlocal indentexpr=GetYamlIndent()
  setlocal indentkeys=o,O,*<Return>,!^F
  setlocal shiftwidth=2 softtabstop=2 tabstop=2
  function! GetYamlIndent()
    let lnum = v:lnum - 1
    if lnum == 0
      return 0
    endif
    let line = substitute(getline(lnum),'\s\+$','','')
    let indent = indent(lnum)
    let increase = indent + &sw
    if line =~ ':$'
      return increase
    else
      return indent
    endif
  endfunction
  au BufNewFile,BufRead *.yaml,*.yml setf yaml
augroup END
" }}}2

augroup ft_tmux " {{{2
  au!
  au BufNewFile,BufReadPost *.tmux.* setlocal filetype=tmux
augroup END
" }}}2

augroup ft_vim " {{{2
  au!
  au FileType vim setlocal foldmethod=marker
  au BufReadPost  *.vimrc nnoremap K :exe ":h ".expand("<cword>")<CR>
  au BufWritePost .vimrc source $MYVIMRC
augroup END
" }}}2

augroup ft_text " {{{2
  au!
  au FileType text,txt setlocal textwidth=79 linebreak
  au BufNewFile,BufReadPost *.txt setlocal formatoptions+=t
augroup END
" }}}2

augroup ft_tex " {{{2
  au!
  au FileType tex setlocal foldmarker={%{,}%}
  au FileType tex setlocal textwidth=79 formatoptions+=l iskeyword+=:
  au FileType tex setlocal complete+=kspell
  au FileType tex silent! compiler tex

  " To *fix* the slow cursorline and relativenumber option:
  au FileType tex setlocal lazyredraw

  " Surround plugin shortcuts.
  au FileType tex let g:surround_{char2nr('1')} = "\\textbf{\r}"
  au FileType tex let g:surround_{char2nr('e')} = "\\begin{\1environment: \1}\r\\end{\1\1}"
augroup END
" }}}2

augroup ft_python " {{{2
  au!
  au FileType python setlocal shiftwidth=2 softtabstop=2 tabstop=2
augroup END
" }}}2

augroup ft_php " {{{2
  au!
  au FileType php setlocal shiftwidth=2 softtabstop=2 tabstop=2
  "exception: highlight php semicolon
  au Syntax * hi php_semicolon cterm=none ctermfg=253 ctermbg=238
  au Syntax * call matchadd('php_semicolon', ';$')
augroup END
" }}}2

augroup ft_markdown " {{{2
  au!
  au BufNewFile,BufReadPost *.m*down,*.md setlocal filetype=markdown
  au FileType markdown setlocal textwidth=79 nolinebreak
  au FileType markdown setlocal shiftwidth=2 softtabstop=2 tabstop=2
augroup END
" }}}2

augroup ft_scss " {{{2
  au!
  au BufNewFile,BufReadPost *.scss setlocal filetype=css
  au BufNewFile,BufReadPost *.less setlocal filetype=css
augroup END
" }}}2

augroup ft_mutt " {{{2
  " bound to file location
  au BufNewFile,BufRead /tmp/mutt* set textwidth=74 spelllang=nl
  au BufNewFile,BufRead ~/tmp/mutt* set textwidth=74 spelllang=nl
augroup END
" }}}2

" }}}1

" STATUSLINE {{{1 ------------------------------------------------------------
" when the last window will have a status line
" 2: always
set laststatus=2

" git branch ---------------------------------------------
" function to set branchname with custom pre/su-fix
if filereadable(expand("$HOME/.vim/plugin/gitbranch.vim"))
  source $HOME/.vim/plugin/gitbranch.vim
  function! GitBranchName()
    let br = gitbranch#name()
    "return strlen(br)?'['.br.']':''
    return strlen(br)?'  '.br.' ':''
  endfunction
endif

" clear
set statusline=
" git branch
set statusline+=%#Comment#%{GitBranchName()}%#StatusLine#
" read-only?
set statusline+=%r
" filename
set statusline+=%<%F
" modified? (show '*' instead of '[+]')
set statusline+=%{(&modified)?'*':''}
" date changed
set statusline+=\ %{strftime(\"%H:%M:%S\ %d-%b-%Y\",getftime(expand(\"%:p\")))}
" fileformat
set statusline+=\ [%{&ff}]
" file-encoding
set statusline+=[%{&fileencoding?&fileencoding:&encoding}]
" paste mode?
set statusline+=%{(&paste)?'[paste]':''}
" spelllang (when spell = enabled)
set statusline+=%{(&spell)?'['.toupper(&spelllang).']':''}
" spacer
set statusline+=%=
" curpos: (filetype), ascii-value, lineno, charpos, total/percentage
set statusline+=(%{(&filetype)})\ asc:%03b\ %04c\,%04l\ %4L:%02p%%
" }}}1
