require 'test_helper'

class WaveTest < ActiveSupport::TestCase
  should_belong_to :original, :user
  should_have_many :copies

  should_not_allow_mass_assignment_of :created_at, :id, :updated_at, :user_id

  context '#interpolate' do
    context 'with search term' do
      setup do
        @wave = Factory(:wave, :uri => 'http://example.com/?q=%q')
      end

      should 'empty' do
        assert_equal 'http://example.com/?q=', @wave.interpolate(nil)
      end

      should 'simple' do
        assert_equal 'http://example.com/?q=simple', @wave.interpolate('simple')
      end

      should 'URL encode' do
        assert_equal 'http://example.com/?q=two%20words', @wave.interpolate('two words')
      end
    end

    context 'without search term' do
      setup do
        @wave = Factory(:wave, :uri => 'http://example.com')
      end

      should 'simple' do
        assert_equal 'http://example.com', @wave.interpolate('blah')
      end
    end

    context 'numbered placeholders' do
      should 'just numbers' do
        @wave = Factory(:wave, :uri => 'http://example.com/?a=%1&b=%2')
        assert_equal 'http://example.com/?a=a&b=b', @wave.interpolate('a b')
      end

      should 'numbers and string' do
        @wave = Factory(:wave, :uri => 'http://example.com/?q=%q&a=%1&b=%2')
        assert_equal 'http://example.com/?q=a%20b&a=a&b=b', @wave.interpolate('a b')
      end

      should 'numbers with remainder' do
        @wave = Factory(:wave, :uri => 'http://example.com/?a=%1&b=%2&z=%n')
        assert_equal 'http://example.com/?a=a&b=b&z=c%20d-z', @wave.interpolate('a b c d-z')
      end

      should 'more numbers than words' do
        @wave = Factory(:wave, :uri => 'http://example.com/?a=%1&b=%2&c=%3')
        assert_equal 'http://example.com/?a=a&b=&c=', @wave.interpolate('a')
      end

      should 'repeated numbers' do
        @wave = Factory(:wave, :uri => 'http://example.com/?a=%1&b=%1&c=%n')
        assert_equal 'http://example.com/?a=a&b=a&c=c', @wave.interpolate('a c')
      end
    end
  end
end
