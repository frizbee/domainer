#!/usr/bin/env ruby

require 'fileutils'
require_relative 'libs.rb'

class Domain

def initialize(domain,amount,list,email)
  @domain = domain
  @domain_ = domain.gsub(".","_") unless domain.nil?
  @amount = amount
  @list = list
  @email = email
end

def loop_list
  File.open(@list, "r+") do |file|
    while line = file.gets
      data = line.split(",").map(&:strip)
      @domain = data[0].downcase
      @domain_ = @domain.gsub(".","_")
      @amount = data[1].downcase
      making_domain_folder
      making_nginx_conf
      making_nginx_symlink
    end
  end
end

def manual_set
  making_domain_folder
  making_nginx_conf
  making_nginx_symlink
end

def making_domain_folder
  puts "Starting create directory for domain #{@domain}"
  Dir.mkdir "/var/www/#{@domain_}" unless File.exists? "/var/www/#{@domain_}"
  file = "#{Dir.pwd}/archive.zip"
  dest_folder = "/var/www/#{@domain_}"
  #FileUtils.cp(file, dest_folder)
  extract_zip(file, dest_folder)
  puts "directory with all files has been created successfully"
  if File.file? "#{dest_folder}/index.php"
    original_file = IO.read("#{dest_folder}/index.php")
    open("#{dest_folder}/index.php", "w") do |f|
      f << "<?php $domain = '#{@domain}'; $amount = '#{@amount}'; ?>\n\n"
      f << original_file
    end
  end
  if File.file? "#{dest_folder}/sendthedata.php"
    originaldata_file = IO.read("#{dest_folder}/sendthedata.php")
    open("#{dest_folder}/sendthedata.php", "w") do |f|
      f << "<?php $email = '#{@email}'; $domain = '#{@domain}'; ?>\n\n"
      f << originaldata_file
    end
  end
end

def making_nginx_conf
  puts "Making new NGiNX config file"
  nginx_config = "/etc/nginx/sites-available/#{@domain_}"
  nginx_enabled = "/etc/nginx/sites-enabled/#{@domain_}"
  unless File.file? nginx_enabled
    output = File.open(nginx_config,"w")
    output << "server {\n"
    output << "  listen 80;\n"
    output << "  root /var/www/#{@domain_};\n"
    output << "  index index.php index.html;\n"
    output << "  server_name #{@domain};\n"
    output << "  location / {\n"
    output << "    try_files $uri $uri/ =404;\n"
    output << "  }\n"
    output << "  location ~ \.php$ {\n"
    output << "    include snippets/fastcgi-php.conf;\n"
    output << "    fastcgi_pass unix:/run/php/php7.0-fpm.sock;\n"
    output << "  }\n"
    output << "  location ~ /.ht {\n"
    output << "    deny all;\n"
    output << "  }\n"
    output << "}\n"
  end
end


  def making_nginx_symlink
    puts "Making new NGiNX symlink file"
    nginx_config = "/etc/nginx/sites-available/#{@domain_}"
    nginx_enabled = "/etc/nginx/sites-enabled/#{@domain_}"
    unless File.file? nginx_enabled
      FileUtils.symlink(nginx_config,nginx_enabled)
    end
  end

end
