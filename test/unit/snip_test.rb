require 'test_helper'

class SnipTest < ActiveSupport::TestCase
  should_belong_to :original, :user
  should_have_many :copies

  should_not_allow_mass_assignment_of :created_at, :id, :updated_at, :user_id

  context '#interpolate' do
    setup do
      @snip = Snip.new(:uri => 'http://example.com/')
    end

    should 'pass params to Interpolator and call #interpolate' do
      params = { :l => 'l', :q => 'q', :s => 's' }
      interpolator = mock('interpolator')
      Interpolator.expects(:new).with(params).returns(interpolator)
      interpolator.expects(:interpolate).with('http://example.com/')
      @snip.interpolate(params)
    end
  end
end
