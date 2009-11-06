class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.validates_format_of_login_field_options :with => /\A[a-z0-9_-]+\z/i,
      :message => 'should include only letters, numbers, "-" or "_"'
  end

  has_many :waves, :dependent => :destroy

  attr_accessible :email, :name, :password, :password_confirmation, :username
end
