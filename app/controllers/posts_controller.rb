class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  
  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create  
    @post = Post.new(post_params)
    @post.user = current_user
    
    if @post.save 
      redirect_to posts_path, notice: "El producto ha sido guardado exitosamente"
    else
      flash[:alert] = "El producto no ha sido guardado, por favor repetir la operacion"
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "El artículo fue editado correctamente"
      redirect_to posts_path    
    else
      render :edit  
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    flash[:notice] = "El post se eliminó correctamente"
    redirect_to posts_path
  end

  private

    def post_params
      params.require(:post).permit(:user_id, :category_id, :title, :content, :image)
    end

end
