require_relative '../test_helper'

class ScaffoldModelTest < ActiveSupport::TestCase

  def test_fixtures_validity
    ScaffoldModel.all.each do |scaffold_model|
      assert scaffold_model.valid?, scaffold_model.errors.inspect
    end
  end

  def test_validation
    scaffold_model = ScaffoldModel.new
    assert scaffold_model.invalid?
    # assert_errors_on scaffold_model, :name
  end

  def test_creation
    assert_difference 'ScaffoldModel.count' do
      ScaffoldModel.create(
        :name => 'test name',
      )
    end
  end

end