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

    def self.check
      config_present = File.exists?(ConfigPath)
      puts "no config file(#{ Setup::ConfigPath }) exists" unless config_present
      config_present
    end

  end

  class Notifier
    require 'yaml'

    def run
      return unless Setup.check
    end

    def parse_reminders
      @reminders = YAML::load_file(Setup::ConfigPath)
    end
  end
end
