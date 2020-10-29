" https://gist.github.com/sjl/3360978

" MyFoldText() {{{ ------------------------------------------------------------------------
function! PrePad(s,amt,...)
  if a:0 > 0
    let char = a:1
  else
    let char = ' '
  endif
  return repeat(char,a:amt - len(a:s)) . a:s
endfunction

function! MyFoldText()
  let line = getline(v:foldstart)
  let nucolwidth = &fdc + &number * &numberwidth
  let windowwidth = winwidth(0) - nucolwidth
  let foldedlinecount = v:foldend - v:foldstart
  let spcs = '                '
  while strlen(spcs) < windowwidth | let spcs = spcs . spcs
  endwhile
  " expand tabs into spaces
  let onetab = strpart('          ', 0, &tabstop)
  let line = substitute(line, '\t', onetab, 'g')
  return strpart(line.spcs, 0, windowwidth-5).'('.PrePad(foldedlinecount,3,'0').')'
endfunction
" }}}

set foldtext=MyFoldText()
set foldmethod=marker
