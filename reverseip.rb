#!/usr/bin/env ruby
=begin
Script : reverseip.rb
Description : Get list website that running on same ip
Usage : ./reverseip.rb [domainame]
Author : Mr.Hien (phanquochien@gmail.com)
=end

%w{rubygems nokogiri open-uri socket}.each { |lib| require lib }


appid = "DA1C6AA99F4A36C59483B6C4B8F8D1480B6D5D68"
result = []
domain = ARGV[0]
ip = IPSocket::getaddress(domain)
bing_url = "http://api.bing.net/xml.aspx?Appid=#{appid}&query=IP:#{ip}&sources=web"
doc =  Nokogiri::XML(open(bing_url)).remove_namespaces!
doc.xpath("//SearchResponse//Web//Results//WebResult").each do |url| 
  result << "- " + url.xpath("DisplayUrl").text.split("/")[0]
end
result.uniq!
result.sort!
puts "IP: #{ip} - Total: #{result.size} site(s)."
puts result
