require 'tweetstream'
require 'csv'


config = {
  :consumer_key    　　=> 'じぶんの',
  :consumer_secret 　　=> 'じぶんの',
  :access_token    　　=> 'じぶんの',
  :access_token_secret => "じぶんの"
}

meibo_list = Array.new 
meibo_ary = Array.new
list_tweets = Array.new
count = 0

client = Twitter::Streaming::Client.new(config)
CSV.open('tweet_meibo.csv', 'w') do |meibo|
  client.sample do |tweet|
    tmp_ary = Array.new
    puts count + ""
    if tweet.is_a?(Twitter::Tweet) && tweet.lang == "ja"
      tmp_ary << "@" + tweet.user.screen_name
      tmp_ary << tweet.user.name
      tmp_ary << tweet.user.description
      meibo << tmp_ary
      break if count >= 100 #ほしい名簿の件数をお書き
      count += 1
    end
  end
end