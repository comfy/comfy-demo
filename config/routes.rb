Rails.application.routes.draw do
  namespace :admin do
    resources :shoes
  end

  comfy_route :blog_admin, path: "/admin"
  comfy_route :blog, path: "/blog"
  comfy_route :cms_admin, path: "/admin"
  # Ensure that this route is defined last
  comfy_route :cms, path: "/"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
