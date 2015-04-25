#!/usr/bin/env ruby

require 'json'

def read_meetings
  begin
    file = File.open(File.expand_path("~/.highfive/meetings"), "rb")
    contents = file.read
    file.close

    JSON.parse(contents)
  rescue
    false
  end
end

def write_meetings(meetings='')
  file = File.open(File.expand_path("~/.highfive/meetings"), "wb")
  file.write(meetings)
  file.close
end

if !Dir.exist? File.expand_path('~/.highfive')
  Dir.mkdir File.expand_path('~/.highfive')
end

if !meetings = read_meetings
   abort "Usage: ./highfive.rb subdomain meeting_name" if ARGV.length != 2
   meetings = { ARGV[0].to_sym => [ARGV[1]] }
   write_meetings(JSON.dump(meetings))
end

# Currently only supports one meeting subdomain
# TODO: support more than one subdomain

subdomain, rooms = meetings.first

if ARGV[1] and !rooms.index(ARGV[1])
  rooms.push(ARGV[1])
  meetings[subdomain] = rooms
  write_meetings(JSON.dump(meetings))
end

if rooms.length == 1
  # only one meeting
  room = rooms[0]
elsif ARGV[1]
  room = ARGV[1]
else
  puts "Please select your \"#{subdomain}\" meeting:"

  rooms.each_with_index do |r, i|
    puts "[#{i+1}] #{r}"
  end

  print "Selection: "

  until i = $stdin.gets.chomp.to_i and i > 0 and room = rooms[i-1]
    print "Invalid selection. Selection: "
  end
end

highfive_path = File.expand_path('~/Applications/HighfiveApp.app/Contents/MacOS/highfive_launcher_prod')
message = JSON.dump({ :message => "launchUrl", :url => "highfive://call?domain=#{subdomain}&meeting=#{room}" })
input = [message.length, message].pack('LA*')

IO.popen(highfive_path, 'r+') do |process|
  process.puts input
  process.close_write
end
