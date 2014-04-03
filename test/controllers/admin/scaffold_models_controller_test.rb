require_relative '../../test_helper'

class Admin::ScaffoldModelsControllerTest < ActionController::TestCase

  def setup
    ::Cms::Site.create!(
      :label      => 'Test Site',
      :identifier => 'tst',
      :hostname   => 'tst.test'
    )
    @request.env['HTTP_AUTHORIZATION'] = "Basic #{Base64.encode64('username:password')}"
    
    @scaffold_model = scaffold_models(:default)
  end

  def test_get_index
    get :index
    assert_response :success
    assert assigns(:scaffold_models)
    assert_template :index
  end

  def test_get_show
    get :show, :id => @scaffold_model
    assert_response :success
    assert assigns(:scaffold_model)
    assert_template :show
  end

  def test_get_show_failure
    get :show, :id => 'invalid'
    assert_response :redirect
    assert_redirected_to :action => :index
    assert_equal 'Scaffold Model not found', flash[:error]
  end

  def test_get_new
    get :new
    assert_response :success
    assert assigns(:scaffold_model)
    assert_template :new
    assert_select 'form[action=/admin/scaffold_models]'
  end

  def test_get_edit
    get :edit, :id => @scaffold_model
    assert_response :success
    assert assigns(:scaffold_model)
    assert_template :edit
    assert_select "form[action=/admin/scaffold_models/#{@scaffold_model.id}]"
  end

  def test_creation
    assert_difference 'ScaffoldModel.count' do
      post :create, :scaffold_model => {
        :name => 'test name',
      }
      scaffold_model = ScaffoldModel.last
      assert_response :redirect
      assert_redirected_to :action => :show, :id => scaffold_model
      assert_equal 'Scaffold Model created', flash[:success]
    end
  end

  def test_creation_failure
    assert_no_difference 'ScaffoldModel.count' do
      post :create, :scaffold_model => { }
      assert_response :success
      assert_template :new
      assert_equal 'Failed to create Scaffold Model', flash[:error]
    end
  end

  def test_update
    put :update, :id => @scaffold_model, :scaffold_model => {
      :name => 'Updated'
    }
    assert_response :redirect
    assert_redirected_to :action => :show, :id => @scaffold_model
    assert_equal 'Scaffold Model updated', flash[:success]
    @scaffold_model.reload
    assert_equal 'Updated', @scaffold_model.name
  end

  def test_update_failure
    put :update, :id => @scaffold_model, :scaffold_model => {
      :name => ''
    }
    assert_response :success
    assert_template :edit
    assert_equal 'Failed to update Scaffold Model', flash[:error]
    @scaffold_model.reload
    refute_equal '', @scaffold_model.name
  end

  def test_destroy
    assert_difference 'ScaffoldModel.count', -1 do
      delete :destroy, :id => @scaffold_model
      assert_response :redirect
      assert_redirected_to :action => :index
      assert_equal 'Scaffold Model deleted', flash[:success]
    end
  end
end