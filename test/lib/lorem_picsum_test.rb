require_relative '../test_helper'

class LoremPicsumTest < ActiveSupport::TestCase

  def test_init
    tag = LoremPicsum.new(context: nil, params: ["600", "400"])
    assert_equal "600", tag.width
    assert_equal "400", tag.height
  end

  def test_content
    tag = LoremPicsum.new(context: nil, params: ["600", "400"])
    assert_equal "<img src='https://picsum.photos/600/400'/>", tag.content
  end

end
