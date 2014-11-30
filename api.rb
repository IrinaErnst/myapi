require 'rubygems'
require 'sinatra'
require 'json'
 
class API < Sinatra::Base
 
  get '/' do
    '<html><body><h1>Place-it!</h1></body></html>'
  end
 
  # Test locally w/ 'curl -i http://localhost:5000/rooms.json'
  #                 'curl -i http://localhost:5000/rooms.json\?beacon_id=abc\&maj_val\=1\&min_val\=1'
  get '/beacons.json' do
    content_type :json
 
    if params[:beacon_id] == 'abc' && params[:maj_val].to_i == 1 && params[:min_val].to_i == 1
      beacon_name = "Green"
    elsif params[:beacon_id] == 'abc' && params[:maj_val].to_i == 1 && params[:min_val].to_i == 2
      beacon_name = "Purple"
    else
      beacon_name = "Blue"
    end
 
    {:name => beacon_name,
     :beacon_id => params[:beacon_id],
     :maj_val => params[:maj_val].to_i,
     :min_val => params[:min_val].to_i}.to_json
  end


end