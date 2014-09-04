class Admin::CategoriesController < ApplicationController
  respond_to :html, :js
  before_filter :authenticate_user!,:is_admin?
  
  def is_admin?
    unless current_user.role.name == "admin"
      flash[:notice] = "You are not authorized to view that."
      self.route_to_proper_controller
    end
  end

  def index
  	@allcategory = Categorie.all.paginate(page: params[:page], per_page: 2)
    #@allcategory = Categorie.paginate(:all, :order => "name ASC", :per_page => 2, :page => params[:page])
  end

  def show
  	@category = Categorie.find(params[:id])
  end

  def new
    @category = Categorie.new
  end
  
  def create
    @allcategory = Categorie.all.paginate(page: params[:page], per_page: 2)
    @category = Categorie.create(cat_params)
  end

  def edit
    @category = Categorie.find(params[:id])
  end


  def update
    @allcategory = Categorie.all.paginate(page: params[:page], per_page: 2)
    @category = Categorie.find(params[:id])
    @category.update_attributes(cat_params)
  end

  def destroy
    Categorie.find(params[:id]).destroy
    flash[:success] = "Category deleted successfully"
    redirect_to [:admin_categories]
  end

 

  private
    def cat_params
       params.require(:categorie).permit(:name)
    end
 

end
