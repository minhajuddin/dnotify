module Dnotify
  class Setup
    require 'fileutils'
    require 'tempfile'

    ConfigPath = File.expand_path "~/.dnotifyrc"

    def self.run
      setup unless check
      write_crontab
    end

    def self.setup
      FileUtils.cp(File.join(File.dirname(__FILE__), '../resources/dnotifyrc.sample.yaml'), ConfigPath)
      puts "copied default template to #{ConfigPath}"
    end

    def self.write_crontab
      existing_crontab = `crontab -l`
      return if existing_crontab =~ /dnotify/i
      #copied from https://github.com/javan/whenever/blob/master/lib/whenever/command_line.rb
      puts 'setting up cron'
      tmp_cron_file = Tempfile.new('dnotify_tmp_cron').path
      File.open(tmp_cron_file, File::WRONLY | File::APPEND) do |file|
        file << existing_crontab << "* * * * * /bin/bash -l -c 'dnotify >> /tmp/dnotify.log'\n"
      end
      puts `crontab #{tmp_cron_file}`
    end

    def self.check
      config_present = File.exists?(ConfigPath)
      if config_present
        puts 'dnotify is setup'
      else
        puts "no config file(#{ Setup::ConfigPath }) exists"
      end
      config_present
    end

  end

  class Notifier
    require 'yaml'
    require 'chronic'
    require 'libnotify'

    DefaultNotification = {:body => "Alarm", :summary => "Alarm", :timeout => 2.5, :icon_path => File.join(File.dirname(__FILE__),'../resources/clock.png') }

    def initialize
      ENV['DISPLAY'] = config[:display]
    end

    def run
      return unless Setup.check
      #check if a reminder aligns with the current time
      reminders.each do |reminder|
        notify(reminder) if trigger?(reminder)
      end
    end

    def notify(reminder)
      Libnotify.show(DefaultNotification.merge(reminder))
    end

    def trigger?(reminder)
      reminder_time = Chronic.parse(reminder[:time], :context => :past)
      now = Time.now.floor
      reminder_time == now
    end

    def reminders
      config[:reminders]
    end

    def config
      @config ||= YAML::load_file(Setup::ConfigPath)
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
