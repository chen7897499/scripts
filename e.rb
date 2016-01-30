require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'uri'
require 'openssl'

if ARGV[0].nil?
 puts "what website would you like to scrape?"
 link = STDIN.gets.chomp
else
 link = ARGV[0]
end

url = link
if ARGV[1].nil?
 puts "how many pages?"
 pages = STDIN.gets.chomp.to_f
else
 pages = ARGV[1].to_f
end

page = 1

def make_absolute( href, root )
  URI.parse(root).merge(URI.parse(href)).to_s
end

for page in 1..pages+1
Nokogiri::HTML(open(url)).xpath("//div[@class='gdtm']//a/@href").each do |node|
   src = Nokogiri::HTML(open(node)).xpath("//img/@src")[4]
   File.open('./result.html', 'a+') {|f| f.puts("<a href=\"#{make_absolute(src,node)}\">1</a>")}
end
url = link + "?p=#{page}"
end
