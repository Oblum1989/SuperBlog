class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :is_user?, except: [:index, :show, :new, :create]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  
  def index
    @posts = Post.all.order(created_at: :desc)
    @categories = Category.all
  end

  def show
    @user_posts = Post.where(user_id: @post.user_id) 
    @comment = Comment.new
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
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "El artículo fue editado correctamente"
      redirect_to posts_path    
    else
      render :edit  
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = "El post se eliminó correctamente"
    redirect_to posts_path
  end

  private

    def post_params
      params.require(:post).permit(:user_id, :category_id, :title, :content, :image)
    end

    def set_post
      @post = Post.find(params[:id])
    end

    def is_user?
      @post = Post.find(params[:id])
      unless current_user.id == @post.user_id
        flash[:alert] = "You don't have permissions"
        redirect_to posts_path
      end
    end

end
