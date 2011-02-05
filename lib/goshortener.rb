require "rubygems"
require "bundler/setup"

require "rest_client"
require "json"


class GoShortener

  def initialize
    @base_url = "https://www.googleapis.com/urlshortener/v1/url"
  end

  def shorten(long_url)
    if long_url.is_a?(String)
      request_json = {'longUrl' => long_url}.to_json

      begin
        response = RestClient.post @base_url, request_json, :accept => :json, :content_type => :json
      rescue
        raise "Please provide a valid url string"
      end

    else
      raise "Please provide a valid url string"
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
    # go.lengthen("http://goo.gl/TCZHi")      #=> "http://github.com/luckydev"
    #
    # go.lengthen("http://www.goo.gl/TCZHi")  #=> Error
    # go.lengthen("goo.gl/TCZHi")             #=> Error
    # go.lengthen("http://goo.gl/")           #=> Error
    # go.lengthen("http://goo.gl/T")          #=> Error
    # go.lengthen("http://bit.ly/TCZHi")      #=> Error
    #
    ##
    if short_url.is_a?(String)
      request_params = {:shortUrl => short_url}

      begin
        response = RestClient.get @base_url, :params => request_params
      rescue
        raise "Please provide a valid goo.gl short url to lengthen"
      end

    else
      raise "Please provide a valid goo.gl short url to lengthen"
    end
    response = JSON.parse response
    long_url = response["longUrl"]
    return long_url
  end

end 
