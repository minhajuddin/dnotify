dnotify
=======

This is a simple gem which allows you to setup reminders using a simple yaml file allowing you to use natural language. Run the following commands to set it up:

    gem install dnotify
    dnotify setup

Add your reminders to ~/.dnotifyrc (don't forget to setup the right display id)

    #~/.dnotifyrc (get your display id by running: env|grep DISPLAY)
    ---
    :display: ':1.0'
    :reminders:
    - :summary: Time to play badminton
      :time: 5:09 in the evening
    - :summary: Call it a day
      :time: 5:10 in the evening

Enjoy!

TODO
====
- add a few tests
- allow listing of reminders
