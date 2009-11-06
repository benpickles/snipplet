Factory.define :user do |f|
  f.sequence(:email) { |n| "bob-#{n}@example.com" }
  f.sequence(:username) { |n| "user-#{n}" }
  f.password 'password'
  f.password_confirmation { |f| f.password }
end

Factory.define :wave do |f|
  f.association :user
  f.sequence(:command) { |n| n.to_s(36) }
  f.uri 'http://www.google.com/search?q=%s'
end
