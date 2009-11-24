require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should_have_many :snips

  should_not_allow_values_for :username, 'account', 'login', 'snips' # etc

  should_not_allow_mass_assignment_of :created_at, :crypted_password, :id,
    :password_salt, :persistance_token, :updated_at
end
