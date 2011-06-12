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
    require 'chronic'

    def run
      return unless Setup.check
      #check if a reminder is aligns with the current time
      reminders.each do |reminder|
        notify(reminder) if trigger?(reminder)
      end
    end

    def notify(reminder)
      puts reminder[:text]
    end

    def trigger?(reminder)
      reminder_time = Chronic.parse(reminder[:time], :context => :past)
      now = Time.now.floor
      reminder_time == now
    end

    def reminders
      @reminders ||= YAML::load_file(Setup::ConfigPath)
    end
  end
end

class Time
  def round(seconds = 60)
    Time.at((self.to_f / seconds).round * seconds)
  end

  def floor(seconds = 60)
    Time.at((self.to_f / seconds).floor * seconds)
  end
end
