require File.join(File.dirname(__FILE__), 'test_helper')

class GoShortenerTest < Test::Unit::TestCase

  def setup
    @goshortener = GoShortener.new
    @url_to_shorten = "http://github.com/luckydev"
  end

  def test_shorten
    short_url = @goshortener.shorten(@url_to_shorten)
    assert_match /goo\.gl/, short_url
  end


  def test_lengthen
    short_url = @goshortener.shorten(@url_to_shorten)
    assert_match /goo\.gl/, short_url

    long_url = @goshortener.lengthen(short_url)
    assert_equal long_url, @url_to_shorten
  end

end
