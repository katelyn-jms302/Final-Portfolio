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
    require 'twitter'
    client = Twitter::REST::Client.new do |config|
        config.consumer_key        = "KiTNpI4rqUWeuh0KR9CB32lyV"
        config.consumer_secret     = "emN6pNQlSqN7WfP7xaWBhNGSh2tGBv7Ugi9XN7JCWKg22CUNGX"
        config.access_token        = "51299621-Rpoj1F586SXNLQrDYgEagdbDSib2tJIewdkr6rzS6"
        config.access_token_secret = "2EOto7unip5Ebot0bCGPqzZFw2lLUMQLGcd92HZikGNcX"
end
   
    @search_results = client.search("@mercerfootball", result_type: "recent").take(30).collect do |tweet|
      #"#{tweet.user.screen_name}: #{tweet.text}"
        tweet 
end
    
    @title = "My _____ Tweets"
    @description = "This page my tweets that ______"
    @works = "active"
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