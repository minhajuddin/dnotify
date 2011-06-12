module Dnotify
  class Setup
    require 'fileutils'

    ConfigPath = File.expand_path "~/.dnotifyrc"

    def self.run
      if check
        puts 'dnotify is already setup'
        return 
      end
      FileUtils.cp(File.join(File.dirname(__FILE__), '../resources/dnotifyrc.sample.yaml'), ConfigPath)
      puts "copied default template to #{ConfigPath}"
    end

    private

    def self.check
      File.exists?(ConfigPath)
    end

  end

  class Notifier
  end
end
