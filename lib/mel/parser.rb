require 'ripper'

module Mel
  class Parser < Ripper
    def on_def(method, args, _body)
      output = "def #{method}"
      output += "(#{args.join(', ')})" unless args.nil?
      puts output
    end

    def on_defs(target, separator, method, args, _body)
      output = "#{target}#{separator}#{method}"
      output += "(#{args.join(', ')})" unless args.nil?
      puts output
    end
  end
end
