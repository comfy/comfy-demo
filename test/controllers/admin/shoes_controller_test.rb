require_relative '../../test_helper'

class Admin::ShoesControllerTest < ActionDispatch::IntegrationTest

  setup do
    @shoe = shoes(:default)
  end

  # Vanilla CMS has BasicAuth, so we need to send that with each request.
  # Change this to fit your app's authentication strategy
  def r(verb, path, options = {})
    headers = options[:headers] || {}
    headers['HTTP_AUTHORIZATION'] =
      ActionController::HttpAuthentication::Basic.encode_credentials(
        ComfortableMexicanSofa::AccessControl::AdminAuthentication.username,
        ComfortableMexicanSofa::AccessControl::AdminAuthentication.password
      )
    options.merge!(headers: headers)
    send(verb, path, options)
  end

  def test_get_index
    r :get, admin_shoes_path
    assert_response :success
    assert assigns(:shoes)
    assert_template :index
  end

  def test_get_show
    r :get, admin_shoe_path(@shoe)
    assert_response :success
    assert assigns(:shoe)
    assert_template :show
  end

  def test_get_show_failure
    r :get, admin_shoe_path('invalid')
    assert_response :redirect
    assert_redirected_to action: :index
    assert_equal 'Shoe not found', flash[:danger]
  end

  def test_get_new
    r :get, new_admin_shoe_path
    assert_response :success
    assert assigns(:shoe)
    assert_template :new
    assert_select "form[action='/admin/shoes']"
  end

  def test_get_edit
    r :get, edit_admin_shoe_path(@shoe)
    assert_response :success
    assert assigns(:shoe)
    assert_template :edit
    assert_select "form[action='/admin/shoes/#{@shoe.id}']"
  end

  def test_creation
    assert_difference 'Shoe.count' do
      r :post, admin_shoes_path, params: {shoe: {
        name: 'test name',
        color: 'test color',
      }}
      shoe = Shoe.last
      assert_response :redirect
      assert_redirected_to action: :show, id: shoe
      assert_equal 'Shoe created', flash[:success]
    end
  end

  def test_creation_failure
    assert_no_difference 'Shoe.count' do
      r :post, admin_shoes_path, params: {shoe: { }}
      assert_response :success
      assert_template :new
      assert_equal 'Failed to create Shoe', flash[:danger]
    end
  end

  def test_update
    r :put, admin_shoe_path(@shoe), params: {shoe: {
      name: 'Updated'
    }}
    assert_response :redirect
    assert_redirected_to action: :show, id: @shoe
    assert_equal 'Shoe updated', flash[:success]
    @shoe.reload
    assert_equal 'Updated', @shoe.name
  end

  def test_update_failure
    r :put, admin_shoe_path(@shoe), params: {shoe: {
      name: ''
    }}
    assert_response :success
    assert_template :edit
    assert_equal 'Failed to update Shoe', flash[:danger]
    @shoe.reload
    refute_equal '', @shoe.name
  end

  def test_destroy
    assert_difference 'Shoe.count', -1 do
      r :delete, admin_shoe_path(@shoe)
      assert_response :redirect
      assert_redirected_to action: :index
      assert_equal 'Shoe deleted', flash[:success]
    end
  end
end
