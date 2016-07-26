#!/usr/bin/env ruby

require 'fileutils'
require_relative 'libs.rb'
require_relative 'domain.rb'

domain = nil
amount = nil
list = nil
prompt = ">"

puts "Do you want to run it Automaticly (a) or Manual (m)?"
puts "Type your answer (a|m)"
print prompt

while type = gets.chomp.downcase
  case type
  when "m"
    puts "Please enter domain name:"
    print prompt
    domain = gets.chomp.downcase
    puts "Enter amount:"
    print prompt
    amount = gets.chomp
    break
  when "a"
    puts "Type full path to file with comma separeted domain names:\n"
    print prompt
    list = gets.chomp
    break
  else
    puts "Plese type 'm' for manual or 'a' for automatic"
    print prompt
  end
end

puts "Please add your contact email address, where you will receive offers"
print prompt
email = gets.chomp.downcase

d = Domain.new(domain,amount,list,email)

if type == "a"
 if File.file? list
   d.loop_list
 end
else
  d.manual_set
end


puts "Restarting server"
%x`service nginx restart`

puts "Done!"
