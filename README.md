dnotify
=======

This is a simple gem which allows you to setup reminders using a simple yaml file allowing you to use natural language. Run the following commands to set it up:

    gem install dnotify
    dnotify setup

Add your reminders to ~/.dnotifyrc

    #~/.dnotifyrc
    --- 
    - :summary: Time to play badminton
      :time: 10:27 in the evening
    - :summary: Time to reminisce
      :time: 9 in the evening saturday
    - :summary: Call it a day
      :time: 10:28 in the evening

Enjoy!
