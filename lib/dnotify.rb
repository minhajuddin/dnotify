module Dnotify
  class Notifier
    require 'fileutils'

    ConfigPath = File.expand_path "~/.dnotifyrc"


    def self.check
      File.exists?(ConfigPath)
    end

    def self.setup
      return if check || !confirm_setup
      FileUtils.cp(File.join(File.dirname(__FILE__), '../resources/dnotifyrc.sample.yaml'), ConfigPath)
      puts "copied default template to #{ConfigPath}"
    end

    def self.confirm_setup
      puts "You dont' seem to have the dnotify setup, do you want an empty config file(#{ ConfigPath }) to be created?(yes/y/no/n)"
      answer = !!(gets =~ /(y|yes)/i)
      puts "Exiting dnotify" if !answer
      answer
    end
  end
end
