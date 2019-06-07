class CommentsController < ApplicationController
    def create
        @post = Post.find(params[:post_id])
        @post.comments.create(comments_params)
        redirect_to post_path(@post) 
    end

    def destroy
        @post = Post.find(params[:post_id])
        @comment = @post.comments.find(params[:id])
        @comment.destroy
        redirect_to post_path(@post)
    end

    def edit
        @post = Post.find(params[:post_id])
        @comment = @post.comments.find(params[:id])
    end

    def update
        @post = Post.find(params[:post_id])
        @comment = @post.comments.find(params[:id])
        @comment.update(comments_params)
        redirect_to post_path(@post)
    end
    
    

    private
        def comments_params
            params.require(:comment).permit(:content).merge(user: current_user)
        end
end
