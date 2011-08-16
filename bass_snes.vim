" Vim syntax file
" Language:	65c816/SNES Assembler (bass syntax)
" Maintainer:	Johannes Baiter
" Last change:	2011 Aug 16
"
" This is still fairly incomplete and WIP, use with caution!
"

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn case ignore

" Operators
syn match bassOperator      "[-+*/]"
syn match bassOperator      "<<"
syn match bassOperator      ">>"
syn match bassOperator      "&"
syn match bassOperator      "!"
syn match bassOperator      "!!"
syn match bassOperator      "<>"
syn match bassOperator      "="
syn match bassOperator      ">="
syn match bassOperator      "<="
syn match bassOperator      "=="

" Valid Processor registers
syn match bassReg           "(adc|asl|bit|cmp|dec|eor|lda|ldy|lsr|ora|rol|ror|sbc|sta|sty|stz) \$[0-9a-f]{2}\+x"ms=e-2,hs=e
syn match bassReg           "(adc|asl|bit|cmp|dec|eor|lda|ldy|lsr|ora|ror|sbc|sta|stz) \$[0-9a-f]{4}\+x"ms=e-2,hs=e
syn match bassReg           "(ldx|stx) \$[0-9a-f]{2}\+y"ms=e-2,hs=e
syn match bassReg           "(adc|cmp|eor|lda|ldx|ora|sbc|sta) \$[0-9a-f]{4}\+y"ms=e-2,hs=e

" Valid Opcodes
syn keyword bassOpcode      adc asl bit brk clc cld cli clv cmp cop cpx cpy
syn keyword bassOpcode      dec dex dey eor jml jmp jsl jsr lda ldx ldy lsr
syn keyword bassOpcode      mvp ora pea pei per pha phb phd phk php phx phy
syn keyword bassOpcode      pla plb pld plp plx ply rep rol ror rti rtl rts
syn keyword bassOpcode      sbc sec sed sei sep sta stp stx sty stz tax tay
syn keyword bassOpcode      tcd tcs tdc trb tsb tsc tsx txa txs txy tya tyx
syn keyword bassOpcode      wai wdm xba xce bcc bcs beq bmi bne bpl bra inc
syn keyword bassOpcode      inx iny

" Valid labels
syn match bassLabel         "^\w*:$"
syn match bassLabel         "[~+-];"
syn match bassLabel         "namespace \w+(\n|;)"ms=s+9,hs=s+9,he=e-1

" Builtin commands
syn keyword bassBuiltin     print warning error define endian
syn keyword bassBuiltin     org base pushpc pullpc align fill seek db dw dl
syn keyword bassBuiltin     dd dq namespace mapper

" Conditionals
syn keyword bassConditional if elseif else endif

" Macros
syn keyword bassMacro       macro endmacro

" Various address formats
syn match hexNumber         "\$[0-9a-f]*"
syn match hexNumber         "\$([0-9a-f]{2}|[0-9a-f]{4}|[0-9a-f]{6})"
syn match binNumber         "%([01]{8}|[01]{16}|[01]{24})"

" Character/String formats
syn match bassChar          "define \'.\'"ms=e-3,hs=e-2,he=e-2
syn match bassString        "\".*\""

" Immediate data
syn match bassImmediate     "#\$[0-9a-f]*"
syn match bassImmediate     "#%[0-9a-f]*"
syn match bassImmediate     "#\$([0-9a-f]{2}|[0-9a-f]{4}|[0-9a-f]{6})"

" Special items for comments
syn keyword bassTodo        contained TODO
syn keyword bassFixme       contained FIXME

" Comments
syn match bassComment       "//.*" contains=bassTodo,bassFixme

" Include
syn keyword bassInclude     incsrc incbin


syn case match

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_bass_syntax_inits")
  if version < 508
    let did_bass_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  " The default methods for highlighting.  Can be overridden later
  " Comment Constant Error Identifier PreProc Special Statement Todo Type
  "
  " Constant		Boolean Character Number String
  " Identifier		Function
  " PreProc		Define Include Macro PreCondit
  " Special		Debug Delimiter SpecialChar SpecialComment Tag
  " Statement		Conditional Exception Keyword Label Operator Repeat
  " Type		StorageClass Structure Typedef

  HiLink bassBuiltin            Function
  HiLink bassLabel              Function

  HiLink bassComment            Comment
  HiLink bassTodo               Todo
  HiLink bassFixme              Todo

  HiLink hexNumber              Number          " Constant
  HiLink binNumber              Number          " Constant
  HiLink decNumber              Number          " Constant

  HiLink bassImmediate          SpecialChar     " Statement

  HiLink bassChar               Character
  HiLink bassString             String          " Constant

  HiLink bassReg                Identifier
  HiLink bassOperator           Identifier

  HiLink bassInclude            Include         " PreProc
  HiLink bassMacro              Macro           " PreProc

  HiLink bassOpcode             Statement
  HiLink bassCond               Conditional     " Statement

  delcommand HiLink
endif

let b:current_syntax = "bass_snes"
