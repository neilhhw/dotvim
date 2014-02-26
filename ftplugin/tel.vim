if exists("b:did_ftplugin") | finish | endif
let b:did_ftplugin = 1

" Make sure the continuation lines below do not cause problems in
" compatibility mode.
let s:save_cpo = &cpo
set cpo-=C

if exists("loaded_matchit")
    let b:match_words =
     \  '\<while\>:\<endwhile\>,' .
     \  '\<switch\>:\<endswitch\>,' .
     \  '\<if\>:\<elseif\>:\<else\>:\<endif\>,' .
     \  '\<function\>:\<endfunction\>,' .
     \  '\<for\>:\<endfor\>,'
endif


