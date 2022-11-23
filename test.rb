# docker compose run app ruby test.rb

## Todo
# - [ ] 定期実行 1/h  
# - [ ] 対象のページからdom取得
# - [ ] xml生成
# - [ ] 生成したxmlをもとにrss feedを作成
# - [ ] rss feedをgithub pagesで公開

# =======
puts "start"

require 'dotenv'
Dotenv.load
require 'nokogiri' # https://github.com/sparklemotion/nokogiri#parsing-and-querying
require 'open-uri'
require 'pry'
require "rss"

target_url = ENV["TARGET_URL"]
tmp_file_path = "./tmp/tmp_file.html"
tmp_file_path2 = "./tmp/tmp_file2.html"
tmp_file_path3 = "./tmp/tmp_file3.html"
tmp_file_path4 = "./tmp/tmp_file4.html"
tmp_file_path5 = "./tmp/tmp_file5.txt"
tmp_file_path6 = "./tmp/tmp_file6.xml"
tmp_file_path7 = "./tmp/tmp_file7.xml"

doc = Nokogiri::HTML(URI.open(target_url))

def write_file(file_path, data)
  File.open(file_path, "w") { |f| f.write(data) }
end

# write_file(tmp_file_path, doc)

#main-column > div.top-section.clearfix > div.right-section > div.top-news > ul.article-list
# //*[@id="main-column"]/div[1]/div[2]/div[4]/ul[1]

x_path = '//*[@id="main-column"]/div[1]/div[2]/div[4]/ul[1]'

a = doc.at_css('ul.article-list')
b = doc.xpath(x_path)
# write_file(tmp_file_path2, a)
# write_file(tmp_file_path3, b)


c = doc.xpath('//*[@id="main-column"]/div[1]/div[2]/div[4]/ul[1]/li')
# [8] pry(main)> nodes.count
# => 15

# nodes = b
# [2] pry(main)> nodes.count
# => 1

nodes = c
parsed_nodes = nodes.map do |node|
  hash = {}
  # //*[@id="main-column"]/div[1]/div[2]/div[4]/ul[1]/li[1]/a
  # //*[@id="main-column"]/div[1]/div[2]/div[4]/ul[1]/li[2]/a
  # //*[@id="main-column"]/div[1]/div[2]/div[4]/ul[1]/li[3]/a
  # ...
  # //*[@id="main-column"]/div[1]/div[2]/div[4]/ul[1]/li[N]/a
  # binding.pry
  # title1 = node.children[1].children[7].children[0].text
  # title2 = node.children[1].children[3].children[0].text
  # title3 = node.children[1].children[5].children[0].text
  # time = node.children[1].children[5].children[0].text
  # node.children[1].children でeachで検索する?
  # 最低限URLがあればよさそうだけど
  path = node.children[1].attribute("href").value # path以外Nokogiri::XML::Elementの位置が異なる
  # hash[:title] = 
  hash[:path] = path
  # hash[:time]  = 
  hash
end

# write_file(tmp_file_path4, nodes)
# write_file(tmp_file_path5, parsed_nodes)

# parsed_nodes
# [{:path=>"/articles/-/1429650"}, {:path=>"/articles/-/1429632"}, {:path=>"/articles/-/1429609"}, {:path=>"/articles/-/1429590"}, {:path=>"/articles/-/1429582"}, {:path=>"/articles/-/1429467"}, {:path=>"/articles/-/1429416"}, {:path=>"/articles/-/1429251"}, {:path=>"/articles/-/1429247"}, {:path=>"/articles/-/1429244"}, {:path=>"/articles/-/1429243"}, {:path=>"/articles/-/1429235"}, {:path=>"/articles/-/1429234"}, {:path=>"/articles/-/1429008"}, {:path=>"/articles/-/1429000"}]

# p parsed_nodes
# p parsed_nodes.count

# https://docs.ruby-lang.org/ja/latest/library/rss.html
# >RSS 2.0の生成
# もし，RSS 2.0を生成したい場合は以下のように， RSS::Maker.makeの第一引数を変更します．

def xml_builder
  rss = RSS::Maker.make("2.0") do |maker|
    xss = maker.xml_stylesheets.new_xml_stylesheet
    xss.href = "http://test.hushita-h.xyz"
    maker.channel.about = "http://example.com/index.rdf"
    maker.channel.title = "Example"
    maker.channel.description = "Example Site"
    maker.channel.link = "http://example.com/"
    
    maker.items.do_sort = true
    
    maker.items.new_item do |item|
      item.link = "http://example.com/article.html"
      item.title = "Sample Article"
      item.date = Time.parse("2004/11/1 10:10")
    end
    
    maker.items.new_item do |item|
      item.link = "http://example.com/article2.html"
      item.title = "Sample Article2"
      item.date = Time.parse("2004/11/2 10:10")
    end
    
    maker.image.title = "Example Site"
    maker.image.url = "http://example.com/logo.png"
    
    maker.textinput.title = "Search Example Site"
    maker.textinput.description = "Search Example Site's all text"
    maker.textinput.name = "keyword"
    maker.textinput.link = "http://example.com/search.cgi"
  end
end

def xml_atom_builder
  rss = RSS::Maker.make("atom") do |maker|
    xss = maker.xml_stylesheets.new_xml_stylesheet
    xss.href = "http://example.com/index.xsl"

    maker.channel.about = "http://example.com/atom.xml"
    maker.channel.title = "Example"
    maker.channel.description = "Example Site"
    maker.channel.link = "http://example.com/"

    maker.channel.author = "Bob"
    maker.channel.date = Time.now

    maker.items.do_sort = true

    maker.items.new_item do |item|
      item.link = "http://example.com/article.html"
      item.title = "Sample Article"
      item.date = Time.parse("2004/11/1 10:10")
    end

    maker.items.new_item do |item|
      item.link = "http://example.com/article2.html"
      item.title = "Sample Article2"
      item.date = Time.parse("2004/11/2 10:10")
    end

    maker.image.title = "Example Site"
    maker.image.url = "http://example.com/logo.png"

    maker.textinput.title = "Search Example Site"
    maker.textinput.description = "Search Example Site's all text"
    maker.textinput.name = "keyword"
  end
end
  
# p xml_builder
# p xml_builder.class # RSS::Rss
# write_file(tmp_file_path6, xml_builder)
p xml_atom_builder
p xml_atom_builder.class # RSS::Atom::Feed
write_file(tmp_file_path7, xml_atom_builder)

puts "end"
