require 'ripper'

module Mel
  class Parser < Ripper
    def on_def(method, args, body)
      output = "def #{method}"
      output += "(#{args.join(', ')})" unless args.nil?
      puts output
    end

    def on_defs(target, separator, method, args, body)
      output = "#{target}#{separator}#{method}"
      output += "(#{args.join(', ')})" unless args.nil?
      puts output
    end
  end
end
