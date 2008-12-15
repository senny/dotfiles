syn region anyString matchgroup=anyStringDelimiter start="\"" end="\"" skip="\\\\\|\\\""
syn match anyElement "/.*$" contains=anyString
syn match  anyComment "#.*"
syn match anyStatement "\$.\{-}\s"
syn match anyBlockStart "/\w\{-}\s*$"
syn region anyBlock start="/\w\{-}\_\s\{-}{" end="}" transparent fold

hi def link anyComment			Comment
hi def link anyString           String
hi def link anyStringDelimiter  Delimiter
hi def link anyStatement        Statement
hi def link anyElement          Identifier
hi def link anyBlockStart       Type

if has('folding')
    setlocal foldmethod=syntax
endif
