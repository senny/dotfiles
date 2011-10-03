#!/usr/bin/ruby
require "rubygems"
require 'irb/completion'
require 'irb/ext/save-history'

IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"

require 'logger'
if ENV.include?('RAILS_ENV') && !Object.const_defined?('RAILS_DEFAULT_LOGGER')
   Object.const_set('RAILS_DEFAULT_LOGGER', Logger.new(STDOUT))
else
   ActiveRecord::Base.logger = Logger.new(STDOUT)
end

class Object
  # list methods which aren't in superclass
  def local_methods(obj = self)
    (obj.methods - obj.class.superclass.instance_methods).sort
  end

  # print documentation
  #
  #   ri 'Array#pop'
  #   Array.ri
  #   Array.ri :pop
  #   arr.ri :pop
  def ri(method = nil)
    unless method && method =~ /^[A-Z]/ # if class isn't specified
      klass = self.kind_of?(Class) ? name : self.class.name
      method = [klass, method].compact.join('#')
    end
    puts `ri '#{method}'`
  end

  def quick(repetitions=100, &block)
    require 'benchmark'

    Benchmark.bmbm do |b|
      b.report {repetitions.times &block}
    end
    nil
  end
end
