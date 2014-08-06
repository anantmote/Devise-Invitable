class Admin::PagesController < ApplicationController

  before_filter :authenticate_user!

  def index
  	@page = Page.all
  end

  def show
  	@page = Page.find(params[:id])
  end

  def new
    #@category = Categorie.all
    @page = Page.new
  end
  
  def create
    @page = Page.new(page_params)    
    if @page.save
      flash[:success] = "Page is added successfully!"
      redirect_to [:admin, @page]
    else
      render 'new'
    end
  end

  def edit
    @page = Page.find(params[:id])
  end

  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(page_params)
      flash[:success] = "Page is updated successfully!"
      redirect_to [:admin_page]
    else
      render 'edit'
    end
  end

  def destroy
    Page.find(params[:id]).destroy
    flash[:success] = "Page deleted successfully"
    redirect_to [:admin_pages]
  end

  private
    def page_params
       params.require(:page).permit(:title,:content,:categorie_id)
    end
 


end
