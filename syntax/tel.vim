" Vim syntax file
" Language:	Hit macro
" Maintainer:	Claudio Fleiner <claudio@fleiner.com>
" Updaters:	Scott Shattuck (ss) <ss@technicalpursuit.com>
" URL:		http://www.fleiner.com/vim/syntax/javascript.vim
" Changes:	(ss) added keywords, reserved words, and other identifiers
"		(ss) repaired several quoting and grouping glitches
"		(ss) fixed regex parsing issue with multiple qualifiers [gi]
"		(ss) additional factoring of keywords, globals, and members
" Last Change:	2012 Oct 05
" 		2013 Jun 12: adjusted telRegexpString (Kevin Locke)

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
" tuning parameters:
" unlet tel_fold

if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'tel'
elseif exists("b:current_syntax") && b:current_syntax == "tel"
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

" Drop fold if it set but vim doesn't support it.
if version < 600 && exists("tel_fold")
  unlet tel_fold
endif


syn region  telDefine		start="^\s*\(%:\|#\)\s*\(define\|undef\)\>" skip="\\$" end="$"

syn keyword telCommentTodo      TODO FIXME XXX TBD contained
syn match   telLineComment      "\/\/.*" contains=@Spell,telCommentTodo
syn match   telCommentSkip      "^[ \t]*\*\($\|[ \t]\+\)"
syn region  telComment	       start="/\*"  end="\*/" contains=@Spell,telCommentTodo
syn match   telSpecial	       "\\\d\d\d\|\\."
syn region  telStringD	       start=+"+  skip=+\\\\\|\\"+  end=+"\|$+	contains=telSpecial,@htmlPreproc
syn region  telStringS	       start=+'+  skip=+\\\\\|\\'+  end=+'\|$+	contains=telSpecial,@htmlPreproc

syn match   telSpecialCharacter "'\\.'"
syn match   telNumber           display "\<\d*\>"
syn match   telNumber           display "\<0x\x*\>"
syn region  telRegexpString     start=+/[^/*]+me=e-1 skip=+\\\\\|\\/+ end=+/[gim]\{0,2\}\s*$+ end=+/[gim]\{0,2\}\s*[;.,)\]}]+me=e-1 contains=@htmlPreproc oneline

syn keyword telFunction         function endfunction
syn keyword telConditional	if else switch endif elseif endswitch
syn keyword telRepeat		while for endfor endwhile
syn keyword telBranch		break continue
syn keyword telOperator		new delete instanceof typeof AND NOT OR LAST
syn keyword telType		integer string
syn keyword telStatement        return with
syn keyword telBoolean		true false
syn keyword telNull		null undefined
syn keyword telIdentifier	arguments this var let
syn keyword telLabel		case default
syn keyword telException        try catch finally throw
syn keyword telMessage		alert confirm prompt status
syn keyword telGlobal		self window top parent
syn keyword telMember		document event location 
syn keyword telDeprecated	escape unescape
syn keyword telReserved		abstract boolean byte char class const debugger double enum export extends final float goto implements import int interface long native package private protected public short static super synchronized throws transient volatile 

if main_syntax == "tel"
  syn sync ccomment telComment
endif

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_javascript_syn_inits")
  if version < 508
    let did_javascript_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  HiLink telComment		Comment
  HiLink telLineComment		Comment
  HiLink telCommentTodo		Todo
  HiLink telSpecial		Special
  HiLink telStringS		String
  HiLink telStringD		String
  HiLink telCharacter		Character
  HiLink telSpecialCharacter	telSpecial
  HiLink telNumber		Number
  HiLink telConditional		Conditional
  HiLink telRepeat		Repeat
  HiLink telBranch		Conditional
  HiLink telOperator		Operator
  HiLink telType	        Type
  HiLink telStatement		Statement
  HiLink telFunction		Function
  HiLink telError		Error
  HiLink javaScrParenError		telError
  HiLink telNull			Keyword
  HiLink telBoolean		Boolean
  HiLink telRegexpString		String

  HiLink telIdentifier		Identifier
  HiLink telLabel		Label
  HiLink telException		Exception
  HiLink telMessage		Keyword
  HiLink telGlobal		Keyword
  HiLink telMember		Keyword
  HiLink telDeprecated		Exception 
  HiLink telReserved		Keyword
  HiLink telDebug		Debug
  HiLink telConstant		Label
  HiLink telDefine              Macro

  delcommand HiLink
endif

let b:current_syntax = "tel"
if main_syntax == 'tel'
  unlet main_syntax
endif
let &cpo = s:cpo_save
unlet s:cpo_save

" vim: ts=8
