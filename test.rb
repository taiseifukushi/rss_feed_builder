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

target_url = ENV["TARGET_URL"]
puts target_url

puts "end"
