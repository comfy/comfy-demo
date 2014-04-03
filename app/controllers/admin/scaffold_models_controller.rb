class Admin::ScaffoldModelsController < Admin::Cms::BaseController

  before_action :build_scaffold_model,  :only => [:new, :create]
  before_action :load_scaffold_model,   :only => [:show, :edit, :update, :destroy]

  def index
    @scaffold_models = ScaffoldModel.page(params[:page])
  end

  def show
    render
  end

  def new
    render
  end

  def edit
    render
  end

  def create
    @scaffold_model.save!
    flash[:success] = 'Scaffold Model created'
    redirect_to :action => :show, :id => @scaffold_model
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = 'Failed to create Scaffold Model'
    render :action => :new
  end

  def update
    @scaffold_model.update_attributes!(scaffold_model_params)
    flash[:success] = 'Scaffold Model updated'
    redirect_to :action => :show, :id => @scaffold_model
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = 'Failed to update Scaffold Model'
    render :action => :edit
  end

  def destroy
    @scaffold_model.destroy
    flash[:success] = 'Scaffold Model deleted'
    redirect_to :action => :index
  end

protected

  def build_scaffold_model
    @scaffold_model = ScaffoldModel.new(scaffold_model_params)
  end

  def load_scaffold_model
    @scaffold_model = ScaffoldModel.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = 'Scaffold Model not found'
    redirect_to :action => :index
  end

  def scaffold_model_params
    params.fetch(:scaffold_model, {}).permit(:name)
  end
end