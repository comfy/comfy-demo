Rails.application.routes.draw do

  namespace :admin do
    resources :shoes
  end

  comfy_route :cms_admin, path: "/admin"
  # Ensure that this route is defined last
  comfy_route :cms, path: "/"
end
