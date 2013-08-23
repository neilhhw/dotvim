" Vim syntax file
" Language:	SDL
" Maintainer:	Michael Piefel <piefel@informatik.hu-berlin.de>
" Modifier:	Neil Hou <neilhhw@gmail.com>
" Last Change: 29/10/10 14:51:35	

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif

if !exists("sdl_2000")
    syntax case ignore
endif

" A bunch of useful SDL keywords {{{
syn keyword sdlTodo         TODO FIXME XXX neilhhw NOTE

syn keyword sdlStatement	task nextstate constant
syn keyword sdlStatement	in out with from interface module representation
syn keyword sdlStatement	to via env and use of near far
syn keyword sdlStatement	master process procedure block system service type implementation
syn keyword sdlStatement	endprocess endprocedure endblock endsystem endtype endimplementation
syn keyword sdlStatement	package endpackage connection endconnection
syn keyword sdlStatement	channel endchannel connect
syn keyword sdlStatement	synonym dcl signal gate timer signallist signalset
syn keyword sdlStatement	create set reset call
syn keyword sdlStatement	operators literals services library endlibrary
syn keyword sdlStatement	active alternative any as atleast constants
syn keyword sdlStatement	default endalternative endmacro endoperator
syn keyword sdlStatement	endselect endsubstructure external
syn keyword sdlStatement	if then fi for import macro macrodefinition
syn keyword sdlStatement	macroid mod nameclass nodelay not operator or
syn keyword sdlStatement	parent provided referenced rem viewed
syn keyword sdlStatement	select spelling substructure xor fpar returns
syn keyword sdlNewState		state endstate
syn keyword sdlInput		input start stop return none save priority output 
syn keyword sdlConditional	decision join while
syn keyword sdlConditional	else
syn keyword sdlConditional	enddecision endwhile
syn keyword sdlVirtual		virtual redefined finalized adding inherits
syn keyword sdlExported		remote exported export

syn cluster sdlTodo         contains=sdlTodo

"}}}

" String and Character contstants
" Highlight special characters (those which have a backslash) differently
syn match   sdlSpecial		contained "\\\d\d\d\|\\."
syn region  sdlString		start=+"+  skip=+\\\\\|\\"+  end=+"+  contains=cSpecial
syn region  sdlString		start=+'+  skip=+''+  end=+'+

"--{{{----------------------------------------------------华丽的分割线---------------------------

syn region  sdlDefine		start="^\s*\(%:\|#\)\s*\(define\|undef\)\>" skip="\\$" end="$"
syn region  sdlIncluded	        display contained start=+"+ skip=+\\\\\|\\"+ end=+"+
syn match   sdlIncluded	        display contained "<[^>]*>"
syn match   sdlInclude	        display "^\s*\(%:\|#\)\s*include\>\s*["<]" contains=sdlIncluded
syn region  sdlPreCondit        start="^\s*\(%:\|#\)\s*\(if\|ifdef\|ifndef\|elif\)\>" skip="\\$" end="$"
syn match   sdlPreCondit	display "^\s*\(%:\|#\)\s*\(else\|endif\)\>"
syn match   sdlUserDefType      display "[a-zA-Z0-9_]\+_t\>"
syn match   sdlUserConst        display "[a-zA-Z0-9_]\+_c\>"
"syn match   sdlSysDefType       display ""
syn match   sdlFunction         display "\<[a-zA-Z_][a-zA-Z_0-9]*\>[^()]*)("me=e-2
syn match   sdlFunction         display "\<[a-zA-Z_][a-zA-Z_0-9]*\>\s*("me=e-1
syn match   sdlFunction         display "\<[a-zA-Z_][a-zA-Z_0-9]*_r\>"
"========================================================
" Highlight All Math Operator
"========================================================
syn match sdlMathOperator display "[-+\*/%]"
syn match sdlPointerOperator display "@\|\.\$"
syn match sdlLogicalOperator display "="
syn match sdlLogicalOperator display ":="
syn match sdlBinaryOperator display "\(&\||\|\^\|<<\|>>\)=\="
syn match sdlBinaryOperator display "\~"
syn match sdlBinaryOperatorError display "\~="

syn match       sdlNumber               display "\<\d*\>"
syn match       sdlNumber               display "\<0x\x*\>"
syn match       sdlTrue                 display "\<T\>"
syn match       sdlFalse                display "\<F\>"
"---}}}---------------------------------------------------华丽的分割线---------------------------

" No, this doesn't happen, I just wanted to scare you. SDL really allows all
" these characters for identifiers; fortunately, keywords manage without them.
" set iskeyword=@,48-57,_,192-214,216-246,248-255,-

syn region sdlComment		start="/\*"  end="\*/" contains=@sdlTodo
syn region sdlComment		start="comment"  end=";"
syn region sdlComment		start="--" end="--\|$"
syn match  sdlCommentError	"\*/"

syn keyword sdlOperator		present sizeof
syn keyword sdlType		integer real natural duration pid boolean time bool dword byte word bytepointer
syn keyword sdlType		character charstring ia5string
syn keyword sdlType		self now sender offspring
syn keyword sdlStructure	asntype endasntype syntype endsyntype struct endstruct enum endenum union endunion

if !exists("sdl_no_96")
    syn keyword sdlStructure	newtype endnewtype
endif

if exists("sdl_2000")
    syn keyword sdlStructure	object endobject value endvalue
    " The same in uppercase
    syn keyword sdlStructure	OBJECT ENDOBJECT VALUE ENDVALUE
    syn keyword sdlOperator	PRESENT
    syn keyword sdlType		INTEGER NATURAL DURATION PID BOOLEAN TIME
    syn keyword sdlType		CHARSTRING IA5STRING
    syn keyword sdlType		SELF NOW SENDER OFFSPRING
    syn keyword sdlStructure	ASNTYPE ENDASNTYPE SYNTYPE ENDSYNTYPE STRUCT
endif

" ASN.1 in SDL
syn case match
syn keyword sdlType		SET OF BOOLEAN INTEGER REAL BIT OCTET RESET
syn keyword sdlType		SEQUENCE CHOICE
syn keyword sdlType		STRING OBJECT IDENTIFIER NULL

syn sync ccomment sdlComment

"----{{{---------------------美好的修改---------------------------------------
" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_sdl_syn_inits")
    if version < 508
	let did_sdl_syn_inits = 1
	command -nargs=+ HiLink hi link <args>
	command -nargs=+ Hi     hi <args>
    else
	command -nargs=+ HiLink hi def link <args>
	command -nargs=+ Hi     hi def <args>
    endif

    HiLink  sdlException	Label
    HiLink  sdlConditional	sdlStatement
    HiLink  sdlVirtual		sdlStatement
    HiLink  sdlExported		sdlFlag
    HiLink  sdlCommentError	sdlError
    HiLink  sdlOperator		Operator
    HiLink  sdlStructure	sdlType
    Hi	    sdlStatement	term=bold ctermfg=4 guifg=Blue
    Hi	    sdlFlag		term=bold ctermfg=4 guifg=Blue gui=italic
    Hi	    sdlNewState		term=italic ctermfg=2 guifg=Magenta gui=underline
    Hi	    sdlInput		term=bold guifg=Red
    Hi      sdlUserDefType      term=italic ctermfg=3 guifg=PaleGoldenrod
    Hi      sdlUserConst        term=bold guifg=IndianRed gui=bold
    Hi      sdlFunction         gui=NONE guifg=#B5A1FF
    Hi      sdlLogicalOperator  guifg=#3EFFE2
    Hi      sdlPointerOperator  guifg=#3EFFE2
    Hi      sdlBinaryOperator   guifg=#3EFFE2
    Hi      sdlMathOperator     guifg=#3EFFE2
    Hi      sdlTrue             guifg=GreenYellow gui=bold
    Hi      sdlFalse            guifg=GreenYellow gui=bold
    HiLink  sdlType		        Type
    HiLink  sdlString		    String
    HiLink  sdlDefine           Macro
    HiLink  sdlInclude          Include
    HiLink  sdlIncluded         String
    HiLink  sdlPreCondit        PreCondit
    HiLink  sdlComment		    Comment
    HiLink  sdlSpecial		    Special
    HiLink  sdlError		    Error
    HiLink  sdlNumber           Number
    HiLink  sdlTodo		        Todo

    delcommand HiLink
    delcommand Hi

endif
"----}}}---------------------美好的修改---------------------------------------

let b:current_syntax = "sdl"

" vim: ts=4
