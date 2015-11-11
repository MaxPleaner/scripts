#!/home/max/.rbenv/shims/ruby
  
require 'open-uri'  
require 'mechanize'  
require 'colorize'  
  
unless ARGV[0]  
  puts 'Usage: ./craigslist.rb <query>'  
  exit  
end
  
query = ARGV[0]  
craigslist_url = 'http://sfbay.craigslist.org'  
  
url = []  
url << "http://sfbay.craigslist.org/search/sss"  
url << "?catAbb=hhh"  
url << "&query=#{query}"  
url << "&zoomToPosting="  
url << "&minAsk=800"  
url << "&maxAsk=1400"  
url << "&hasPic=1"  
url = url.join  
  
mech = Mechanize.new { |agent|  
  agent.user_agent_alias = 'Mac Safari'  
}  
  
mech.get(url) do |page|  
  
  page.search("//p[@class='row']").each do |row|  
    link = row.search('a')[0]  
    link_href = /^http/ =~ link['href'] ? link['href'] : craigslist_url + link['href']  
    link_text = row.search('a')[1].text  
    city = row.search("small").text  
    price = row.search("span[@class='price']")[0].text  
    text =  <<-TXT  
    #{price.yellow} #{city} -- #{link_text.cyan}  
    #{link_href.cyan}
    TXT
    puts text
  end  
end  