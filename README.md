highfive.rb
===========

`highfive.rb` is a simple Ruby script for opening a Highfive meeting from the command line. 

## How it works

Suppose you work at **Josh, Inc.** and have a meeting every Tuesday at 11:25am, and Josh, Inc. uses Highfive for their meetings. You have two options for joining this meeting: going to `josh.highfive.com/tuesday` and loading the app, or typing in `tuesday` into the Highfive app interface. The first one is annoying since Highfive isn't a browser app, and the second isn't really annoying but since it doesn't save your history you have to type it in every time and it can get annoying if the meeting name is long or difficult to type, and you wonder why no one else is in the meeting when you've actually typed the name wrong.

This script helps alleviate that. You simply run this script and give it the subdomain and meeting name, and it'll load up the Highfive app from the console. So, if your meeting is `josh.highfive.com/tuesday`, you'd type in `./highfive.rb josh tuesday`. You'll only need to type in the meeting name once, and it remembers both the subdomain and the meeting name. The next time, you'll only need to run `./highfive.rb` and it'll automatically load that first meeting. If you need to load another meeting, just run it like you did the first time. If you run it and it has more than one meeting, it'll ask you to select which one you want to load. 

## Notes

Since I use a Mac, I've only tested this on a Mac, but it should work on other systems if you change the path.

Also, this only supports one subdomain at a time but multiple subdomains will be added in the future! 

## License

MIT Joshua Smock 2015
