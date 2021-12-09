class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  # trước truy cập vào các trang của recipe thì phải đăng nhập, trừ phương thức user 
  
  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end
  
  def destroy
    recipe = Recipe.find(params[:id])
    recipe.destroy
    redirect_to recipe_path
  end
  
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    if @recipe.save
      redirect_to recipe_path(@recipe), notice: 'Thêm thành công'
    else
      render :new
      # trả về trang new với biến recipe đã nhập ở function create
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
    if @recipe.user != current_user
      redirect_to recipes_path, alert: "Không thể chỉnh sửa bài viết của người khác"
    end
  end
  
  def update
    @recipe = Recipe.find(params[:id])
    
    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe), notice: 'Đã chỉnh sửa'
    else
      render :edit
      
      #trả về trang edit với các giá trị đã nhập khi điền form update
    end
  end
  
  
  private
  def recipe_params
    params.require(:recipe).permit(:title, :body, :image)
  end

end
