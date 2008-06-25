ActionController::Routing::Routes.draw do |map|
  map.sponsorship_levels '/sponsorship_levels', :controller => 'pages', :action => 'sponsorship_levels'

  map.root :controller => 'pages', :action => 'home'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
