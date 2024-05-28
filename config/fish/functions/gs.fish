function gs --wraps='git status -s' --description 'alias gs=git status -s'
  git status -s $argv
        
end
