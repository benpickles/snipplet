require 'test_helper'

class InterpolatorTest < ActiveSupport::TestCase
  context '#interpolate' do
    context 'with search term' do
      setup do
        @interpolator = Interpolator.new
        @uri = 'http://example.com/?q=%q'
      end

      should 'empty' do
        assert_equal 'http://example.com/?q=', @interpolator.interpolate(@uri)
      end

      should 'simple' do
        @interpolator.q = 'simple'
        assert_equal 'http://example.com/?q=simple', @interpolator.interpolate(@uri)
      end

      should 'URL encode' do
        @interpolator.q = 'two words'
        assert_equal 'http://example.com/?q=two%20words', @interpolator.interpolate(@uri)
      end
    end

    context 'without search term' do
      setup do
        @interpolator = Interpolator.new
        @uri = 'http://example.com'
      end

      should 'simple' do
        @interpolator.q = 'blah'
        assert_equal 'http://example.com', @interpolator.interpolate(@uri)
      end
    end

    context 'numbered placeholders' do
      setup do
        @interpolator = Interpolator.new
      end

      should 'just numbers' do
        @interpolator.q = 'a b'
        assert_equal 'http://example.com/?a=a&b=b', @interpolator.interpolate('http://example.com/?a=%1&b=%2')
      end

      should 'numbers and string' do
        @interpolator.q = 'a b'
        assert_equal 'http://example.com/?q=a%20b&a=a&b=b', @interpolator.interpolate('http://example.com/?q=%q&a=%1&b=%2')
      end

      should 'numbers with remainder' do
        @interpolator.q = 'a b c d-z'
        assert_equal 'http://example.com/?a=a&b=b&z=c%20d-z', @interpolator.interpolate('http://example.com/?a=%1&b=%2&z=%n')
      end

      should 'more numbers than words' do
        @interpolator.q = 'a'
        assert_equal 'http://example.com/?a=a&b=&c=', @interpolator.interpolate('http://example.com/?a=%1&b=%2&c=%3')
      end

      should 'repeated numbers' do
        @interpolator.q = 'a c'
        assert_equal 'http://example.com/?a=a&b=a&c=c', @interpolator.interpolate('http://example.com/?a=%1&b=%1&c=%n')
      end
    end
  end
end
