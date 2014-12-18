require 'rubygems'
require 'sinatra'
require 'json'
require 'redis'
require 'time'
 
class API < Sinatra::Base

  beacon_id = "B9407F30-F5F8-466E-AFF9-25556B57FE6D" 

  configure do
    if ENV["REDISCLOUD_URL"] 
      uri = URI.parse(ENV["REDISCLOUD_URL"])
      $redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
    else
      $redis = Redis.new
    end
  end

  get '/' do
    '<html><body><h1>Place-it!</h1></body></html>'
  end
 
  #  curl -i 'http://localhost:5000/beacons.json?UUID=B9407F30-F5F8-466E-AFF9-25556B57FE6D&major=21137&minor=30314&receiver=14159874354'
  #  curl -i 'http://localhost:5000/beacons.json?UUID=B9407F30-F5F8-466E-AFF9-25556B57FE6D&major=61334&minor=32857&receiver=14159874354'

  get '/flushall' do
    $redis.flushall
  end 

  get '/sample' do
    $redis.set("m|B9407F30-F5F8-466E-AFF9-25556B57FE6D|21137|30314|14159874354|2014-12-18T18:06:39Z", {"sender"=>"14159874355","message"=>"Hello World Green 39!","created_at"=>"2014-12-18T18:06:39Z"})
    $redis.set("m|B9407F30-F5F8-466E-AFF9-25556B57FE6D|21137|30314|14159874354|2014-12-18T18:06:40Z", {"sender"=>"14159874355","message"=>"Hello World Green 40!","created_at"=>"2014-12-18T18:06:40Z"})
    $redis.set("m|B9407F30-F5F8-466E-AFF9-25556B57FE6D|21137|30314|14159874354|2014-12-18T18:06:41Z", {"sender"=>"14159874355","message"=>"Hello World Green 41!","created_at"=>"2014-12-18T18:06:41Z"})

    $redis.set("m|B9407F30-F5F8-466E-AFF9-25556B57FE6D|61334|32857|14159874354|2014-12-18T18:06:39Z", {"sender"=>"14159874355","message"=>"Hello World Purple 39!","created_at"=>"2014-12-18T18:06:39Z"})
    $redis.set("m|B9407F30-F5F8-466E-AFF9-25556B57FE6D|61334|32857|14159874354|2014-12-18T18:06:40Z", {"sender"=>"14159874355","message"=>"Hello World Purple 40!","created_at"=>"2014-12-18T18:06:40Z"})
    $redis.set("m|B9407F30-F5F8-466E-AFF9-25556B57FE6D|61334|32857|14159874354|2014-12-18T18:06:41Z", {"sender"=>"14159874355","message"=>"Hello World Purple 41!","created_at"=>"2014-12-18T18:06:41Z"})
  end 

  get '/beacons.json' do
    content_type :json

    key = "m|#{params[:UUID]}|#{params[:major]}|#{params[:minor]}|#{params[:receiver]}|*"

    returned_keys = $redis.keys(key)

    key_values = []
    returned_keys.each { |k|
      key_values.push($redis.get(k))
    }
    
   key_values.to_json
  end

  # curl --data "UUID=B9407F30-F5F8-466E-AFF9-25556B57FE6D&major=21137&minor=30314&receiver=14159874354&sender=14155551212&message=Wow, it worked" 'http://localhost:5000/beacons.json'

  post '/beacons.json' do
    content_type :json

    timestamp = Time.now.utc.iso8601
    key = "m|#{params[:UUID]}|#{params[:major]}|#{params[:minor]}|#{params[:receiver]}|#{timestamp}"
    value = {"sender"=>"#{params[:sender]}","message"=>"#{params[:message]}","created_at"=>"#{timestamp}"}

    $redis.set(key, value)

    {"status" => "OK", "key" => key, "value" => value}.to_json
  end

end
