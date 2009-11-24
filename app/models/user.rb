class User < ActiveRecord::Base
  RESERVED_USERNAMES = %w(
    about account admin favicon help images javascripts login logout robots
    snips stylesheets user_sessions
  )

  acts_as_authentic do |c|
    c.validates_format_of_login_field_options :with => /\A[a-z0-9_-]+\z/i,
      :message => 'should include only letters, numbers, "-" or "_"'
  end

  has_many :snips, :dependent => :destroy

  validate :reject_reserved_usernames

  attr_accessible :email, :name, :password, :password_confirmation, :username

  private
    def reject_reserved_usernames
      if RESERVED_USERNAMES.include?(username)
        errors.add(:username, 'has already been taken')
      end
    end
end
