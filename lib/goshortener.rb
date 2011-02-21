require "rubygems"

require "rest_client"
require "json"


class GoShortener

  #initialize with/without api key
  def initialize(api_key="")
    unless api_key == ""
      @api_key = api_key
    else
      puts "[GoShortener] Use Google API key to increase your usage quota."
    end
    @base_url = "https://www.googleapis.com/urlshortener/v1/url"
  end

  #Given a long URL, Returns the true short url using http://goo.gl service
  def shorten(long_url)
    if long_url.is_a?(String)
      request_json = {'longUrl' => long_url}.to_json
      request_url = @api_key ? (@base_url + "?key=#{@api_key}") : @base_url

      begin
        response = RestClient.post request_url, request_json, :accept => :json, :content_type => :json
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

  #Given a short URL, Returns the true long url using http://goo.gl service
  def lengthen(short_url)
    if short_url.is_a?(String)
      request_params = {:shortUrl => short_url}
      request_params.merge!(:key => @api_key) if @api_key

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
