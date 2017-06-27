#!/usr/bin/ruby

#
# Prereq:
# - gem install unirest
#
# Usage:
# ./version.rb file_output dir_output appid environment
#
# ./version.rb version.properties ../../../app AndroidApp develop
# ./version.rb version.properties ../../../app AndroidApp master
#

# require 'unirest'
require 'net/http'
require 'json'

base_url = "http://localhost:3000"

options = { :fileoutput => "version.properties",
            :diroutput =>  "#{`pwd`}/output".delete("\n"),
            :appid => "AndroidApp",
            :environment => "develop"
          }

puts "[version.start] #{Time.now}"


options[:fileoutput] = ARGV[0] if ARGV[0]
options[:diroutput] = ARGV[1] if ARGV[1]
options[:appid] = ARGV[2] if ARGV[2]
options[:environment] = ARGV[3] if ARGV[3]

_output = "#{options[:diroutput]}/#{options[:fileoutput]}"

puts "options: #{options}"




def _get_version_code(appid="", environment="")
  require "open-uri"
  data = URI.parse("#{base_url}/api/v1/version/#{appid}/#{environment}").read
  version = JSON.parse(data)["version"]

  puts "version_code: #{version}"
  version["count"]
end


def _get_version_name(version_code="", environment="development")
  version_name = "0.0.#{version_code}-#{environment[0..2]}"
  puts "version_name: #{version_name}"
  version_name
end



# ------------------------------------------------------------------------------
# 1 - remove version file from output
# 2 - get the last version and Update
# 3 - generate the new version file
# ------------------------------------------------------------------------------


# 1
begin
  File.delete(_output)
rescue
  puts "ERR: version file not found"
end




# 2
version_code = _get_version_code(options[:appid], options[:environment])
version_name = _get_version_name(version_code, options[:environment])

content = "VERSION_CODE=#{version_code}\n" +
          "VERSION_NAME=#{version_name}\n"

puts "content: #{content}"



# 3
open(_output, 'a') { |f| f.puts "#{content}" }





puts "[version.stop] #{Time.now}"
