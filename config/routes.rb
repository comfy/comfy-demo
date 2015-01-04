ComfyDemo::Application.routes.draw do

  namespace :admin do
    resources :scaffold_models
  end

  root :to => 'landing#show'

  comfy_route :blog_admin,  :path => '/admin'
  comfy_route :cms_admin,   :path => '/admin'

  comfy_route :blog,        :path => '/blog'
  comfy_route :cms,         :path => '/demo', :sitemap => false
end
