syn match todoComment "*.*"
syn match todoDefinition "^[QTI]\{1},.\{-},.\{-}:" contains=todoTask,todoQuestion,todoInformation,todoStatus,todoPerson,todoImportant
syn match todoTask "^T" contained
syn match todoQuestion "^Q" contained
syn match todoInformation "^I" contained
syn match todoKeyword "=>"
syn match todoPerson "\(@.\{-}\)," contained
syn match todoStatus "PENDING" contained
syn match todoStatus "DONE" contained
syn match todoStatus "FAILED" contained
syn match todoImportant "IMPORTANT" contained

hi def link todoPerson          Keyword
hi def link todoComment			    Comment
hi def link todoQuestion        Identifier
hi def link todoTask            Define
hi def link todoInformation     Type
hi def link todoKeyword         Keyword
hi def link todoStatus          Special
hi def link todoImportant       Error
