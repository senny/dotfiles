require 'rake'
require 'erb'
require 'fileutils'

task :default => :install

desc "install the dot files into user's home directory"
task :install do
  replace_all = false
  Dir['*'].each do |file|
    next if %w[Rakefile README.rdoc LICENSE misc ohmyzsh vscode config].include? file

    if File.exist?(File.join(ENV['HOME'], ".#{file.sub('.erb', '')}"))
      if File.identical? file, File.join(ENV['HOME'], ".#{file.sub('.erb', '')}")
        puts "identical ~/.#{file.sub('.erb', '')}"
      elsif replace_all
        replace_file(file)
      else
        print "overwrite ~/.#{file.sub('.erb', '')}? [ynaq] "
        case $stdin.gets.chomp
        when 'a'
          replace_all = true
          replace_file(file)
        when 'y'
          replace_file(file)
        when 'q'
          exit
        else
          puts "skipping ~/.#{file.sub('.erb', '')}"
        end
      end
    else
      link_file(file)
    end
  end

  FileUtils.mkdir_p File.expand_path("~/.config")
  link_file "config/zellij", "~/.config/zellij"
  link_file "vscode/settings.json", "~/Library/Application Support/Code/User/settings.json"
  link_file "vscode/keybindings.json", "~/Library/Application Support/Code/User/keybindings.json"
end

def replace_file(file)
  system %Q{rm -rf "~/.#{file.sub('.erb', '')}"}
  link_file(file)
end

def link_file(file, target = nil)
  target ||= "~/.#{file}"
  if File.exist?(File.expand_path(target))
    puts "existing #{target}"
  else
    if file =~ /.erb$/
      puts "generating ~/.#{file.sub('.erb', '')}"
      File.open(File.join(ENV['HOME'], ".#{file.sub('.erb', '')}"), 'w') do |new_file|
        new_file.write ERB.new(File.read(file)).result(binding)
      end
    else
      puts "linking ~/.#{file}"
      system %Q{ln -s "$PWD/#{file}" "#{File.expand_path(target)}"}
    end
  end
end
