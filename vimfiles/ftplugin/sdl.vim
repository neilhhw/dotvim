if exists("b:did_ftplugin") | finish | endif
let b:did_ftplugin = 1

" Make sure the continuation lines below do not cause problems in
" compatibility mode.
let s:save_cpo = &cpo
set cpo-=C

if exists("loaded_matchit")
    let b:match_ignorecase = 1
    let b:match_words =
     \  '\<task\>:\;,' .
     \  '\<dcl\>:\;,' .
     \  '\<output\>:\<to\>:\;,' .
     \  '\<while\>:\<endwhile\>,' .
     \  '\<type\>:\<endtype\>,' .
     \  '\<struct\>:\<endstruct\>,' .
     \  '\<procedure\>:\<endprocedure\>,' .
     \  '\<decision\>:(\s*\w*\s*)\::\<else\>:\<enddecision\>,' .
     \  '\<state\>:\<endstate\>,' .
     \  '\<implementation\>:\<endimplementation\>,' .
     \  '\<process\>:\<endprocess\>,'
endif


