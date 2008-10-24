ActionController::Routing::Routes.draw do |map|
  map.resources :proposals, :collection => { :list => :get }

  map.sponsorship_levels '/sponsorship_levels', :controller => 'pages', :action => 'sponsorship_levels'
  map.agenda '/agenda', :controller => 'pages', :action => 'agenda'
  map.benchmark '/benchmark_consulting', :controller => 'pages', :action => 'bc'
  map.engineyard '/engine_yard', :controller => 'pages', :action => 'ey'

  map.root :controller => 'pages', :action => 'home'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
