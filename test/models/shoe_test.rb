require_relative '../test_helper'

class ShoeTest < ActiveSupport::TestCase

  def test_fixtures_validity
    Shoe.all.each do |shoe|
      assert shoe.valid?, shoe.errors.inspect
    end
  end

  def test_validation
    shoe = Shoe.new
    assert shoe.invalid?
    assert_equal [:name, :color], shoe.errors.keys
  end

  def test_creation
    assert_difference 'Shoe.count' do
      Shoe.create(
        name: 'test name',
        color: 'test color',
      )
    end
  end
end
