require "rubygems"
require "bundler/setup"
Bundler.require(:default)

class InvalidUrlError < Exception; end

class GoShortener

  #initialize with/without api key
  def initialize(api_key="")
    @api_key = api_key unless api_key == ""
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
        raise InvalidUrlError, "Please provide a valid URL"
      end
    else
      raise "Please provide a url String"
    end
    response = JSON.parse response
    response["id"]
  end

  #Given a short URL, Returns the true long url using http://goo.gl service
  def lengthen(short_url)
    url_info(short_url)["longUrl"]
  end

  def analytics(short_url)
    url_info(short_url, :projection => "FULL")["analytics"]
  end

  private
  def url_info(short_url, request_params = {})
    if short_url.is_a?(String)
      request_params.merge!(:shortUrl => short_url)
      request_params.merge!(:key => @api_key) if @api_key
      begin
        response = RestClient.get @base_url, :params => request_params
      rescue
        raise InvalidUrlError, "Please provide a valid URL"
      end
    else
      raise "Please provide a valid http://goo.gl url String"
    end
    response = JSON.parse response
  end

end
