class Admin::ShoesController < Comfy::Admin::BaseController

  before_action :build_shoe,  only: [:new, :create]
  before_action :load_shoe,   only: [:show, :edit, :update, :destroy]

  def index
    @shoes = Shoe.page(params[:page])
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
    @shoe.save!
    flash[:success] = 'Shoe created'
    redirect_to action: :show, id: @shoe
  rescue ActiveRecord::RecordInvalid
    flash.now[:danger] = 'Failed to create Shoe'
    render action: :new
  end

  def update
    @shoe.update_attributes!(shoe_params)
    flash[:success] = 'Shoe updated'
    redirect_to action: :show, id: @shoe
  rescue ActiveRecord::RecordInvalid
    flash.now[:danger] = 'Failed to update Shoe'
    render action: :edit
  end

  def destroy
    @shoe.destroy
    flash[:success] = 'Shoe deleted'
    redirect_to action: :index
  end

protected

  def build_shoe
    @shoe = Shoe.new(shoe_params)
  end

  def load_shoe
    @shoe = Shoe.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:danger] = 'Shoe not found'
    redirect_to action: :index
  end

  def shoe_params
    params.fetch(:shoe, {}).permit(:name, :color)
  end
end
