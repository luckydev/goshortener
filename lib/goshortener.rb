require "rubygems"
require "bundler/setup"

require "rest_client"
require "json"


class GoShortener

  def initialize
    @base_url = "https://www.googleapis.com/urlshortener/v1/url"
  end

  def shorten(long_url)
    if long_url.is_a? String
      request_json = {'longUrl' => long_url}.to_json
      response = RestClient.post @base_url, request_json, :accept => :json, :content_type => :json
    else
      raise "Please provide a valid Long url string"
    end
    response = JSON.parse response
    short_url = response["id"]
    return short_url
  end

  def lengthen(short_url)
    if short_url.is_a? String
      request_params = {:shortUrl => short_url}
      response = RestClient.get @base_url, :params => request_params
    else
      raise "Please provide a valid short url string"
    end
    response = JSON.parse response
    long_url = response["longUrl"]
    return long_url
  end

end 
