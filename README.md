# Domainer
## Build nginx domain config files with landing page

Quick script to setup multiple domains for sale along with landing page.

I was requested to setup landing page for over 300 domains to sale them online with web form to contact domain owner. I build that script for my own needs, feel free to use it, download and modify for your own needs in case you gonna use different http server, php version, etc.

Script has manual domain setup (one domain per run) and automatic (multiple setup from file)

Script really needs refactoring, but working ok.

# Server Requirement

* NGiNX
* Ruby
* PHP 7
* Git


# Usage


Upload files to your server
or run `git clone https://github.com/frizbee/domainer.git`

Install gem "zip"
```
gem install zip
```

Should be run under root privileges

Run
```
./automation.rb
```
Script will ask you the way you want to setup your domain(s), type letter "a" for automatic (multiple domains from file) or "m" manual setup (one domain per run)

### For automatic
Script will ask you to put full path to the file with comma separeted domains file along with price (see exmpl domains.txt) in my case price is in euro.
> Example:
```
domain1.com,1200
domain2.com,1500
domain3.com,400
domain4.com,800
```

### For manual
Script will ask you to type domain name (example.com) and then price in euro

In the end in both case it will ask you to type email address where you want to receive offers from your web form of domain landing page

Done

# Credit
Use, contribute, share
