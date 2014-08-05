class Admin::CategoriesController < ApplicationController

  before_filter :authenticate_user!

  def index
  	@category = Categorie.all
  end

  def show
  	@category = Categorie.find(params[:id])
  end

  def new
  	@category = Categorie.new
  end
  
  def create
    @category = Categorie.new(cat_params)    
    if @category.save
      flash[:success] = "Category is added successfully!"
      redirect_to [:admin, @category]
    else
      render 'new'
    end
  end

  def edit
    @category = Categorie.find(params[:id])
  end

  def update
    @category = Categorie.find(params[:id])
    if @category.update_attributes(cat_params)
      flash[:success] = "Category is updated successfully!"
      redirect_to [:admin_category]
    else
      render 'edit'
    end
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
