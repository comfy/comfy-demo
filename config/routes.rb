Rails.application.routes.draw do

  namespace :admin do
    resources :shoes
  end

  get "/with-cms-fragments",      to: "custom#with_cms_fragments"
  get "/with-cms-page",           to: "custom#with_cms_page"
  get "/with-cms-page-explicit",  to: "custom#with_cms_page_explicit"
  get "/with-cms-layout",         to: "custom#with_cms_layout"

  comfy_route :blog_admin, path: "/admin"
  comfy_route :blog, path: "/blog"

  comfy_route :cms_admin, path: "/admin"
  # Ensure that this route is defined last
  comfy_route :cms, path: "/"
end
