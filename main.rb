require 'sinatra'
require 'sinatra/reloader' if development?

get '/' do 
    @title = "Katelyn Armstrong's Portfolio" 
    @description = "This site displays a few things about Katelyn."
    @home = "active"
    erb :home 
end

get '/about' do
    @title = "About Me"
    @description = "This page provides a short bio for Katelyn Armstrong."
    @about = "active"
    erb :about
end

get '/works' do 
    @title = "My Social Media"
    @description = "This page provides links to Katelyn's public sites."
    @works = "active"
    erb :work
end

get '/tweets' do
    require "twitter"
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "l1jE08nkBTaDjMbWzESb0ESKE"
      config.consumer_secret     = "isu6DNE5ec2brHFD4EH1lH2fEl1VXpgZy2JQD8wZ91I6miiDqI"
      config.access_token        = "2882691561-mJ9F4X53UjWrPuwj0cjrN8T8ZGpdI2nc5jtaSNp"
      config.access_token_secret = "0wTZww32d2zsTIzrLisdi88GIdtA3QdsrKOvlN4VVxUF5"
    end
    
   @search_results = client.search("@Mercerfootball", result_type: "recent").take(15).collect do |tweet|
    #"#{tweet.user.screen_name}: #{tweet.text}"
       tweet
    end 
    
    @title = "Tweets"
    @discripton = "This page provides links to a couple of recent tweets about Mercer football. I don't tweet a lot!!"
    @tweets = "active"
    erb :tweets
end

get '/news' do 
    require 'google-search'
    query = "Mercer football"
    @results = Array.new
    Google::Search::News.new do |search|
        search.query = query
        #search.size = :large
  end.each { |item| @results.push item }
  erb :news
end