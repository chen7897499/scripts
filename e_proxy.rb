require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'uri'
require 'openssl'
 
puts "what website would you like to scrape?"
link = gets.chomp
url = link
puts "how many pages?"
pages = gets.chomp.to_f
page = 1
 
def make_absolute( href, root )
  URI.parse(root).merge(URI.parse(href)).to_s
end
 
for page in 1..pages+1
Nokogiri::HTML(open(url)).xpath("//div[@class='gdtm']//a/@href").each do |node|
   src = Nokogiri::HTML(open(node)).xpath("//img/@src")[4]
   uri = "http://zachwhitehead.com/glype/browse.php?u=" + make_absolute(src,node)
   File.open(File.basename(uri),'wb'){ |f|p f.methods; f.write(open(uri).read) }
end
url = link + "?p=#{page}"
end
