require 'rake'

namespace :emacs do
  namespace :compile do

    task :vendor do
      compile_emacs_files("emacs.d/vendor")
    end

    task :senny do
      compile_emacs_files("emacs.d/senny")
    end

  end
end

namespace :dotfiles do
  desc "install the dot files into user's home directory"
  task :install do
    replace_all = false
    Dir['*'].each do |file|
      next if %w[Rakefile README].include? file

      if File.exist?(File.join(ENV['HOME'], ".#{file}"))
        if replace_all
          replace_file(file)
        else
          print "overwrite ~/.#{file}? [ynaq] "
          case $stdin.gets.chomp
          when 'a'
            replace_all = true
            replace_file(file)
          when 'y'
            replace_file(file)
          when 'q'
            exit
          else
            puts "skipping ~/.#{file}"
          end
        end
      else
        link_file(file)
      end
    end
  end
end

def replace_file(file)
  system %Q{rm "$HOME/.#{file}"}
  link_file(file)
end

def link_file(file)
  puts "linking ~/.#{file}"
  system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
end

def compile_emacs_files(dir)
  sh("emacs -l ~/.emacs -batch -f batch-byte-compile #{dir}/**/*.el")
end
