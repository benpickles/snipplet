ActionController::Routing::Routes.draw do |map|
  map.resource :account
  map.resources :snips, :member => { :copy => :post }

  map.root :controller => :snips

  map.resources :user_sessions, :only => [:create, :destroy, :new]
  map.with_options :controller => :user_sessions do |users|
    users.login  'login',  :action => :new
    users.logout 'logout', :action => :destroy
  end

  map.with_options :controller => :user_snips do |m|
    m.user_snips ':username.:format', :action => :index
    m.user_snip ':username/:command', :action => :run
  end
end
