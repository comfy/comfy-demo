class CustomController < ApplicationController

  def with_cms_fragments
    render
  end

  def with_cms_page
    render
  end

  def with_cms_page_explicit
    render cms_page: "/with-cms-page"
  end

  def with_cms_layout
    render cms_layout: "default", cms_fragments: {
      content: "This is a test for layout"
    }
  end
end
