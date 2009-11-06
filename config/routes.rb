ActionController::Routing::Routes.draw do |map|
  map.resource :account
  map.resources :waves

  map.root :controller => :waves

  map.resources :user_sessions, :only => [:create, :destroy, :new]
  map.with_options :controller => :user_sessions do |users|
    users.login  'login',  :action => :new
    users.logout 'logout', :action => :destroy
  end

  map.with_options :controller => :user_waves, :path_prefix => ':username' do |m|
    m.user_waves '',         :action => :index
    m.user_wave  ':command', :action => :run
  end
end
