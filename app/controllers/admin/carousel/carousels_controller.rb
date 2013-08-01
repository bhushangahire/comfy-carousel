class Admin::Carousel::CarouselsController < Admin::Carousel::BaseController
  
  before_filter :build_carousel,  :only => [:new, :create]
  before_filter :load_carousel,   :only => [:edit, :update, :destroy]
  
  def index
    @carousels = Carousel::Carousel.all
  end
  
  def new
    render
  end
  
  def edit
    render
  end
  
  def create
    @carousel.save!
    flash[:notice] = 'Carousel created'
    redirect_to new_admin_carousel_carousel_slide_path(@carousel)
  
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = 'Failed to create Carousel'
    render :action => :new
  end
  
  def update
    @carousel.update_attributes!(params[:carousel])
    flash[:notice] = 'Carousel updated'
    redirect_to :action => :edit, :id => @carousel
    
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = 'Failed to update Carousel'
    render :action => :edit
  end
  
  def destroy
    @carousel.destroy
    flash[:notice] = 'Carousel removed'
    redirect_to :action => :index
  end
  
protected
  
  def build_carousel
    @carousel = if params[:carousel]
    Carousel::Carousel.new(carousel_params)
    else
      Carousel::Carousel.new
    end
  end
  
  private
  def carousel_params
    params.require(:carousel).permit(:identifier,:label,:dimensions)
  end
  
end