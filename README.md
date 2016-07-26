# Domainer
## Build nginx domain config files with landing page

Quick script to make bulk domains for sale landing page.
Script really needs refactoring, but working ok.

# Server Requirement

* NGiNX
* Ruby
* PHP 7
* Git


# Usage


Upload files to your server

Install gem "zip"
```
gem install zip
```

Should be run under root privileges

Run
```
./automation.rb
```
For now works only in auto mode. Select "a", next type full path to your comma separeted domains file (see exmpl domains.txt)
domain1.com,1200 which 1200 is price

Done

# Credit
Use, contribute, share
