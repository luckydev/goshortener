require "rubygems"
require "bundler/setup"

require "rest_client"
require "json"


class GoShortener

  def initialize
    @base_url = "https://www.googleapis.com/urlshortener/v1/url"
  end

  def shorten(long_url)
    if long_url.is_a?(String) && long_url.present?
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
    ##
    # Accepts a short url shortened by http://goo.gl and returns original
    # long url.
    # 
    # Examples:
    # go = GoShortener.new
    #
    # go.lengthen("http://goo.gl/TCZHi") #=> "http://github.com/luckydev"
    #
    # go.lengthen("http://www.goo.gl/TCZHi") #=> Error
    # go.lengthen("goo.gl/TCZHi")        #=> Error
    # go.lengthen("http://goo.gl/")      #=> Error
    # go.lengthen("http://goo.gl/T")     #=> RestClient::BadRequest: 400 Bad Request
    # go.lengthen("http://bit.ly/TCZHi") #=> Error
    #
    ##
    if short_url.is_a?(String) && short_url =~ /^http:\/\/goo\.gl\/.+$/
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
