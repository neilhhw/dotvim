"========================================================
" Highlight All Function
"========================================================
syn match cFunction "\<[a-zA-Z_][a-zA-Z_0-9]*\>[^()]*)("me=e-2
syn match cFunction "\<[a-zA-Z_][a-zA-Z_0-9]*\>\s*("me=e-1
hi cFunction gui=None guifg=#B5A1FF

"========================================================
" Highlight All Math Operator
"========================================================
" C math operators
" TODO: This should add * and /
syn match cMathOperator display "[-+%=]"
" C pointer operators
syn match cPointerOperator display "->\|\."
" C logical operators - boolean results
syn match cLogicalOperator display "[!<>]=\="
syn match cLogicalOperator display "=="
" C bit operators
syn match cBinaryOperator display "\(&\||\|\^\|<<\|>>\)=\="
syn match cBinaryOperator display "\~"
syn match cBinaryOperatorError display "\~="
" More C logical operators - highlight in preference to binary
syn match cLogicalOperator display "&&\|||"
syn match cLogicalOperatorError display "\(&&\|||\)="

" Math Operator
hi cMathOperator guifg=#3EFFE2
hi cPointerOperator guifg=#3EFFE2
hi cLogicalOperator guifg=#3EFFE2
hi cBinaryOperator guifg=#3EFFE2
hi cBinaryOperatorError guifg=#3EFFE2
hi cLogicalOperator guifg=#3EFFE2
hi cLogicalOperatorError guifg=#3EFFE2

"add new keyword
syn keyword cTodo               contained neilhhw NOTE
syn keyword cType               byte dword word bytepointer
syn keyword cType               error_t pointer_t character_t

"{{{-----------------------------------------------------------

syn match   cUserConst        display "[A-Z0-9_]\+_C\>"
"}}}-----------------------------------------------------------


hi cUserConst      term=bold guifg=IndianRed gui=bold
