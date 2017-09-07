require 'thor'
require 'mel/parser'

module Mel
  class CLI < Thor
    default_command :list

    desc 'list', 'Display list of methods'
    option :file, type: :string, aliases: '-f', required: true

    def list
      Parser.parse(File.open(options[:file], 'r').read)
    end

    desc 'version, -v, --version', 'Print the version'
    map %w[-v --version] => :version

    def version
      puts "mel #{Mel::VERSION}"
    end
  end
end
