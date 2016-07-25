#!/usr/bin/env ruby

require 'fileutils'
require_relative 'libs.rb'
require_relative 'domain.rb'

puts "Do you want to run it Automaticly (a) or Manual (m)?"
puts "Type your answer (a|m):"
type = gets.chomp.downcase
if type == "m"
  puts "Enter domain name:"
  domain = gets.chomp.downcase
  puts "Enter amount:"
  amount = gets.chomp
elsif type == "a"
  puts "Type full path to file with comma separeted domains names:\n"
  list = gets.chomp
  if File.file? list
    d = Domain.new
    d.loop_list(list)
  end
else
  puts "Enter data"
end

puts "Restarting server"
%x`service nginx restart`
