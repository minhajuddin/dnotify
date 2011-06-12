module Dnotify
  class Notifier

    ConfigPath = "~/.dnotifyrc"


    def self.check
      File.exists(ConfigPath)
    end

    def self.setup
      return if check || !confirm_setup
    end

    def self.confirm_setup
      puts "You dont' seem to have the dnotify setup, do you want an empty config file(ConfigPath) to be created?(yes/y/no/n)"
      answer = gets
      return answer =~ /(y|yes)/i
    end
  end
end
