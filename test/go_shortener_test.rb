require File.join(File.dirname(__FILE__), 'test_helper')

class GoShortenerTest < Test::Unit::TestCase

  def setup
    @goshortener = GoShortener.new
    @url_to_shorten = "http://github.com/luckydev"
  end

  def test_shorten_valid_url
    short_url = @goshortener.shorten(@url_to_shorten)
    assert_match /goo\.gl/, short_url
  end

  def test_lengthen_valid_url
    short_url = @goshortener.shorten(@url_to_shorten)
    assert_match /goo\.gl/, short_url

    long_url = @goshortener.lengthen(short_url)
    assert_equal long_url, @url_to_shorten
  end

  def test_analytics_valid_url
    short_url = @goshortener.shorten(@url_to_shorten)
    assert_match /goo\.gl/, short_url

    analytics = @goshortener.analytics(short_url)
    assert_not_nil analytics["allTime"]
    assert_not_nil analytics["month"]
    assert_not_nil analytics["week"]
    assert_not_nil analytics["day"]
    assert_not_nil analytics["twoHours"]
  end

  def test_shorten_invalid_url
    assert_raise InvalidUrlError do
      invalid_url = "someinvalid url"
      @goshortener.shorten(invalid_url)
    end
  end

  def test_lengthen_invalid_url
    assert_raise InvalidUrlError do
      invalid_url = "http://ggooogoga.invalid"
      @goshortener.lengthen(invalid_url)
    end
  end

  def test_analytics_invalid_url
    assert_raise InvalidUrlError do
      invalid_url = "http://ggooogoga.invalid"
      @goshortener.analytics(invalid_url)
    end
  end

  def test_no_string_argument_for_shorten
    assert_raise RuntimeError do
      invalid_url = %W(other than string)
      @goshortener.shorten(invalid_url)
    end
  end

  def test_no_string_argument_for_lengthen
    assert_raise RuntimeError do
      invalid_url = 123
      @goshortener.lengthen(invalid_url)
    end
  end
end
