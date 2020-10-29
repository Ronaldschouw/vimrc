" draxor Theme: v0.3 {{{
"
" https://gitlab.com/datube/vimrc
"
" Copyright (C) 2018 datube
"
"    This program is free software: you can redistribute it and/or modify
"    it under the terms of the GNU General Public License as published by
"    the Free Software Foundation, either version 3 of the License, or
"    (at your option) any later version.
"
"    This program is distributed in the hope that it will be useful,
"    but WITHOUT ANY WARRANTY; without even the implied warranty of
"    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
"    GNU General Public License for more details.
"
"    You should have received a copy of the GNU General Public License
"    along with this package; if not, write to the Free Software
"    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA
"
"    On Debian systems, the complete text of the GNU General
"    Public License can be found in `/usr/share/common-licenses/GPL-3'.
"
" Note: This theme is heavily inspired by the xoria256 theme
"
"}}}

let g:colors_name = 'draxor'

" Script Helpers: {{{1
let s:none      = ['NONE', 'NONE']

function! s:h(scope, fg, ...) " bg, attr_list
  " https://github.com/zenorocha/dracula-theme
  " @author Zeno Rocha <hi@zenorocha.com>
  let l:fg = copy(a:fg)
  let l:bg = get(a:, 1, ['NONE', 'NONE'])
  let l:attrs = get(a:, 2, 'NONE')
  let l:hl_string = [
        \ 'highlight', a:scope,
        \ 'guifg=' . l:fg[0], 'ctermfg=' . l:fg[1],
        \ 'guibg=' . l:bg[0], 'ctermbg=' . l:bg[1],
        \ 'gui=' . l:attrs, 'cterm=' . l:attrs,
        \]
  execute join(l:hl_string, ' ')
endfunction
"}}}1

" Palette: {{{1
"let s:dc_03 = [ 'NONE', 146 ]
"let s:dc_08 = [ 'NONE', 188 ]
"let s:dc_12 = [ 'NONE', 248 ]

let s:dc_00 = [ 'NONE', 0   ]
let s:dc_01 = [ 'NONE', 39  ]
let s:dc_02 = [ 'NONE', 110 ]
let s:dc_04 = [ 'NONE', 150 ]
let s:dc_05 = [ 'NONE', 174 ]
let s:dc_06 = [ 'NONE', 180 ]
let s:dc_07 = [ 'NONE', 182 ]
let s:dc_09 = [ 'NONE', 196 ]
let s:dc_10 = [ 'NONE', 229 ]
let s:dc_11 = [ 'NONE', 238 ]
let s:dc_13 = [ 'NONE', 252 ]
let s:dc_14 = [ 'NONE', 244 ]
let s:dc_15 = [ 'NONE', 'green' ]
let s:dc_16 = [ 'NONE', 'red' ]
"
" Color definitions
call s:h('Commented', s:dc_14, s:none)
call s:h('Attention', s:dc_13, s:dc_09, 'bold')
call s:h('Inverted', s:dc_00, s:dc_10)
call s:h('InvertedBold', s:dc_00, s:dc_10, 'bold')
call s:h('Normal', s:dc_13, s:none)
call s:h('Selected', s:dc_00, s:dc_04)
call s:h('StatusLine', s:dc_13, s:dc_11, 'bold')
call s:h('Underline', s:none,s:none,'underline')
call s:h('MatchParen', s:dc_16,s:dc_13)
call s:h('VertSplit', s:dc_11, s:dc_11)
call s:h('Folded', s:dc_02, s:dc_00)
call s:h('TermSel', s:dc_13, s:dc_01)
call s:h('DiffAdd', s:dc_15, s:none, 'bold')
call s:h('DiffText', s:dc_16, s:none, 'bold')
call s:h('dc_02', s:dc_02, s:none)
call s:h('dc_04', s:dc_04, s:none)
call s:h('dc_05', s:dc_05, s:none)
call s:h('dc_06', s:dc_06, s:none)
call s:h('dc_07b', s:dc_07, s:none, 'bold')
call s:h('dc_09', s:dc_09, s:none)
call s:h('dc_10', s:dc_10, s:none)
call s:h('dc_11', s:dc_11, s:none)
"call s:h('SelectedBold', s:dc_00, s:dc_04, 'bold')
"call s:h('dc_01', s:dc_00, s:none)
"call s:h('dc_01', s:dc_01, s:none)
"call s:h('dc_03', s:dc_03, s:none)
"call s:h('dc_07', s:dc_07, s:none)
"call s:h('dc_08', s:dc_08, s:none)
"call s:h('dc_12', s:dc_12, s:none)
"call s:h('dc_13', s:dc_13, s:none)
"call s:h('dc_14', s:dc_14, s:none)
"}}}1

if exists("syntax_on")
  syntax reset
endif

set background=dark

" normal
hi! link Normal         Normal
hi! link Comment        Commented
hi! link Title          dc_07b

" spelling
hi! link SpellBad       Attention
hi! link SpellCap       Selected
hi! link SpellLocal     Underline

" selections
hi! link Search         Selected
hi! link IncSearch      Attention
hi! link Visual         Selected
hi! link VisualNOS      Selected
hi! link BadWhitespace  Attention
hi! link Pmenu          StatusLine
hi! link PmenuSel       Selected


" differences
hi! link DiffAdd        DiffAdd
hi! link DiffChange     Normal
hi! link DiffDelete     DiffText
hi! link DiffText       DiffText

" syntax
hi! link Constant       dc_10
hi! link Number         dc_06
hi! link Float          Number
hi! link Boolean        Number
hi! link Special        dc_05
hi! link Identifier     dc_07b
hi! link Statement      dc_02
hi! link PreProc        dc_04
hi! link Type           dc_04
hi! link Ignore         dc_11
hi! link Error          dc_09
hi! link Directory      dc_02
hi! link LineNR         Commented
hi! link CursorLineNR   dc_10
hi! link MatchParen     Matchparen
hi! link ToDo           Selected

" menu / status
hi! link WildMenu       InvertedBold
hi! link StatusLine     StatusLine

" foldings
hi! link Folded         Folded

" vim separator
hi! link VertSplit      VertSplit


if expand("$DISPLAY") == "$DISPLAY"
  " fix for non X terminals
  hi! link WildMenu     TermSel
  hi! link PmenuSel     TermSel
  hi! link Visual       TermSel
endif

if &diff
  " fix for diff
  hi! Todo ctermbg=none
endif
